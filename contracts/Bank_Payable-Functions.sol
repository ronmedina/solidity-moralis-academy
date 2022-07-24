// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
contract Bank_Payable{

    mapping (address => uint) balance;
 
    //State variable
    address owner; 

    //event logs
    event deposited (uint indexed amount, address indexed depositedTo);
    event transferedAmount(address indexed from, address indexed to, uint indexed amount);

    //Modifier is for restricting permissions like "only employees", "admins", or "owner" etc...
    //modifier onlyOwner {
    //    require(msg.sender == owner);  
    //    _;
    //}

    // Constructor to initialize var
    constructor(){
        owner = msg.sender; 
    }

    function deposit() public payable returns (uint) { 
        balance[msg.sender] += msg.value; // just keeps track of internal balances & no longer needed because we don't need to track internal balances
        emit deposited (msg.value, msg.sender);      //log event
        return balance[msg.sender];
    }

    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }

    function withdraw(uint amount) public returns (uint){
        require(balance[msg.sender]>= amount,"ERROR 1_Insufficient balance to withdraw funds.");
        msg.sender.transfer(amount);
        balance[msg.sender] -= amount;
        return balance[msg.sender];
    }

    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender]>= amount,"ERROR 1_Insufficient balance to transfer funds.");  //Check balance of msg.sender
        require(msg.sender != recipient,"ERROR 2_The sender cannot be the recipient.");

        uint previousSenderBalance = balance[msg.sender];
        _transfer (msg.sender, recipient, amount);  
        emit transferedAmount(msg.sender, recipient, amount);  //log event
        assert(balance[msg.sender] == previousSenderBalance - amount); 

    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

}