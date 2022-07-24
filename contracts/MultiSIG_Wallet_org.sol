// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
//pragma abicoder v2;

//Inheritance - Parent-child relationships
import "./Ownable.sol";
import "./Ownerlist.sol";


/**
 * @title Multisig Wallet
 * @author ronmedina@superiorblocks.io
 * @dev Multisig Wallet Smart Contract where multiple “signatures” or approvals 
 * are needed for an outgoing transfer to take place. The wallet requires determine 
 * many signatures are required to do a transfer. Anyone can deposit funds. 
 * As soon as we want to spend funds, it requires the specified number of approvals.
 */
contract Multisig_Wallet is Ownable, Ownerlist {

    //State VARs
    uint approved;
    uint RequiredApprovals;
    uint limit;

    //Constructor

    constructor(address[] memory _owners, uint _limit) {
        owner = _owners;
        limit = _limit-numApprovals;
    }

    //Mapping
    mapping (address => uint) balance;

    /**each address points to 
    * a mapping where you can input the ID of the request and it returns true/false
    */
    mapping(address => mapping(uint => bool)) approvals;  
    mapping[msg.sender][TransferID] = true/false;


    //Struct
    //Keeps record of address, approvals, amounts, and prevents owner approving/transferring more than once.
    struct Transfer{
        uint amount; //amount to be transferred
        address payable receiver;  //payable receiving address
        uint approved; //required number of signed approvals
        bool hasBeenSent; //flag whether transfer has already been sent
        uint id;
    }

    //Array
    address[] public owners;
    Transfer[] transferRequests;  //Store all transfer request

    //event logs
    event deposited (uint indexed amount, address indexed depositedTo);
    event transferedAmount(address indexed from, address indexed to, uint indexed amount);

    /**
     * @dev A method that sets the required number of approvals setter function.
     * @param _number The number of approvals required.
     */
    function setRequiredApprovals(uint _number) public onlyOwner {
        RequiredApprovals = _number;
    }

    /**
     * @dev A method that gets the required number of approvals.
     * @return RequiredApprovals Number of approvals required.
     */
    function getRequiredApprovals() public view returns(uint){
        return RequiredApprovals;
    }

    /**
     * @dev A method to make a deposit.
     * @return balance of the sender.
     */
     
     // EMPTY FUNCTION ??? <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= <= 
    function deposit() public payable returns (uint) { 
        balance[msg.sender] += msg.value; 
        emit deposited (msg.value, msg.sender);      //log event
        return balance[msg.sender];
    }
    
    //Create an instance of the Transfer struct and add it to the transferRequests array
    function createTransfer(uint _amount, address payable _receiver, uint _approved, bool _hasBeenSent/**, uint _id*/) public only Owners{
        transferRequests.push(Tranfer(_amount, _receiver, 0, false, transferRequests.length));
    }

    //Only allow people in the owners list to continue the execution of transfers.
    modifier onlyOwners(){
        bool owner = false;
        for(uint i=0; i<owners.length;i++){
            if (owners[i] == msg.sender){
                owner = true;
            }
        }
        require(owner == true);
        _;
    }
        

    /**
     * @dev A method to get the sender's balance.
     * @return balance of the sender.
     */
    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }

    /**
     * @dev A method to make a withdrawal only if there is sufficient balance.
     * @param amount The amount to withdraw.
     * @return balance of the sender/owner.
     */
    function withdraw(uint amount) public returns (uint){
        require(balance[msg.sender]>= amount,"ERROR 1_Insufficient balance to withdraw funds.");
        payable(msg.sender).transfer(amount);
        balance[msg.sender] -= amount;
        return balance[msg.sender];
    }

    /**
     * @dev A method to make a transfer.  The sender must be the owner,
     * have sufficient balance, and cannot be the recipient.  The method calls _transfer
     * @param recipient The address of the recipient.  amount The amount to be 
     * transferred from owner and sent to recipient.
     */
    function transfer(address recipient, uint amount) onlyOwner public {
        require(balance[msg.sender]>= amount,"ERROR 2_Insufficient balance to transfer funds.");  //Check balance of msg.sender
        require(msg.sender != recipient,"ERROR 3_The sender cannot be the recipient.");
        require(isOwner(msg.sender), "ERROR 5_You are not an owner and not allowed to make transfer."); // fail hard
        require(RequiredApprovals <= approved, "ERROR 6_Not enough owners have approved the transfer.");

        uint previousSenderBalance = balance[msg.sender];
        _transfer (msg.sender, recipient, amount);  
        emit transferedAmount(msg.sender, recipient, amount);  //log event

        assert(balance[msg.sender] == previousSenderBalance - amount); 
    }
 
    /**
     * @dev A simple method to approve a transfer by an owner.
     * @return the current number of approved.
     */
    function approveIt(bool _decision) public returns(uint){  
        require(isOwner(msg.sender), "ERROR 7_You are not an owner and not allowed to approve a transfer."); // fail hard
        if(_decision == true){
            approved++;
            return (approved);        
        } 
        else{
            return (approved);
        }
    }
    /**
     * @dev An advanced method to approve a transfer by an owner.
     * @return the current number of approved.
     */
    function approve(uint TransferID, bool _decision) public returns(uint){  
        require(isOwner(msg.sender), "ERROR 7_You are not an owner and not allowed to approve a transfer."); // fail hard
        if(_decision == true){
            approved++;
            return (approved);        
        } 
        else{
            return (approved);
        }
    }

    /**
     * @dev A method that gets the current number of approved transfers.
     * @return approved Current number of approved transfers.
     */
    function getApproved() public view returns(uint){
        return approved;
    }

   /**
     * @dev A method to update the sender's balance and the recipients balance.
     * @param from The address of the sender.  to The address of the recipient.
     */
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}