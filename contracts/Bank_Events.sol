// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
contract Bank_Events{

    mapping (address => uint) balance;
    address owner; //state variable

    //event logs, further cheks, and error handling
    event balanceAdded (uint indexed amount, address indexed depositedTo);
    event transferedAmount(address indexed from, address indexed to, uint indexed amount);

    modifier onlyOwner {
        require(msg.sender == owner);  //A modifier is for restricting permissions like "only employees", "admins", or "owner" etc...
        _;
    }

    constructor(){
        owner = msg.sender; 
    }

    function addBalance (uint _toAdd) public onlyOwner returns (uint){ 
        balance[msg.sender] += _toAdd;
        emit balanceAdded (_toAdd, msg.sender);      //log event
        return balance[msg.sender];
    }

    function getBalance () public view returns (uint){
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