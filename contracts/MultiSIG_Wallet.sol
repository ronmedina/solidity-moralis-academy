// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
pragma abicoder v2;

/**
 * @title Multisig Wallet
 * @author ronmedina@superiorblocks.io
 * @dev Multisig Wallet Smart Contract where multiple signatures/approvals 
 * are needed for an outgoing transfer to take place. Anyone can deposit funds. 
 * As soon as we want to spend funds, it requires the specified number of approvals.
 */
contract Multisig_Wallet {
    //State VARs
    uint requiredSignatures; 

    //Arrays
    address[] public owners;
    Transfer[] transferRequests;  //Store all transfer request

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

    //Constructor
    constructor(address[] memory _owners, uint _requiredSignatures) {
        owners = _owners;
        requiredSignatures = _requiredSignatures;
    }

    //Mappings
    mapping (address => uint) balance;
    mapping(address => mapping(uint => bool)) approvals;  //each address points to a mapping where you can input the ID of the request and it returns true/false

    //Struct - Keeps record of address, approvals, amounts.
    struct Transfer{
        uint amount; //amount to be transferred
        address payable receiver;  //payable receiving address
        uint approvals; //current number of signed approvals
        bool hasBeenSent; //flag whether transfer has already been sent
        uint id;
    }

    //event logs
    event deposited (uint indexed amount, address indexed depositedTo);
    event transferedAmount(address indexed from, address indexed to, uint indexed amount);
    event TransferRequestCreated(uint _id, uint _amount, address _initiator, address _receiver);
    event ApprovalReceived(uint _id, uint _approvals, address _approver);
    event TransferApproved(uint _id);

    /**
     * @dev A method to make a deposit.
     * @return balance of the sender.
     */
    function deposit() public payable returns (uint) { 
        balance[msg.sender] += msg.value; 
        emit deposited (msg.value, msg.sender);      //log event
        return balance[msg.sender];
    }
    
    /**
     * @dev A method that creates an instance of the Transfer struct and push it into the 
     * transferRequests array 
     */
     function createTransfer(uint _amount, address payable _receiver) public onlyOwners{
        require(balance[msg.sender]>= _amount,"ERROR1 createTransfer function:  Insufficient balance to transfer funds.");  //Check balance of msg.sender
        require(msg.sender != _receiver,"ERROR 2 createTransfer function:  The sender cannot be the recipient.");
        emit TransferRequestCreated(transferRequests.length, _amount, msg.sender, _receiver);
        transferRequests.push(
            Transfer(_amount, _receiver, 0, false, transferRequests.length)
        );
    }   

    /**
     * @dev A method to get the sender's balance.
     * @return balance of the sender.
     */
    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }
 
    /**
     * @dev A method to approve a transfer by an owner.  It does the following:
     *  - Sets your approval for one of the transfer requests.
     *  - Updates the Transfer object.
     *  - Updates the mapping to record the approval for the msg.sender.
     *  - When the amount of approvals for a transfer has reached the requiredSignatures, this function sends the transfer to the recipient.
     *  - An owner is not allowed to vote twice.
     *  - An owner is not allowed to vote on a tranfer request that has already been sent.
     */
    function approve(uint _id) public onlyOwners {  
        require(approvals[msg.sender][_id] == false, "ERROR 3_approve function:  Owners are not allowed to vote twice.");
        require(transferRequests[_id].hasBeenSent == false, "ERROR 4_approve function:  Owners are not allowed to vote on a transfer request that has already been sent.");

        approvals[msg.sender][_id] = true;
        transferRequests[_id].approvals++;

        emit ApprovalReceived(_id, transferRequests[_id].approvals, msg.sender);

        if(transferRequests[_id].approvals >= requiredSignatures){
            transferRequests[_id].hasBeenSent = true;
            transferRequests[_id].receiver.transfer(transferRequests[_id].amount);

            emit TransferApproved(_id);
        }
    }

/**
     * @dev A method to get transfer requests array information.
     * @return transferRequest array.
     */
         function getTransferRequests() public view returns (Transfer[] memory){
        return transferRequests;
    }
}