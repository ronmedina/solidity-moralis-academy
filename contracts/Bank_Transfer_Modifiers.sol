// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
//Modifiers

contract Bank_Modifiers{

    mapping (address => uint) balance;
    address owner; 
    modifier onlyOwner {  //Good for requirements & setting permissions like onlyOwner, onlyCustomers, onlyVIPs
        require(msg.sender == owner);
        _;
    }
    modifier costs(uint price) {
        require(msg.value >= price);
        _;
    }
    constructor(){
        owner = msg.sender; //admin or owner privleges
    }

    function addBalance (uint _toAdd) public onlyOwner returns (uint) { 
        //For higher permissions like only employees or owner of bank can add
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }

    function getBalance () public costs(10) view returns (uint){
        return balance[msg.sender];
    }

    function transfer(address recipient, uint amount) public costs(100) {
        //Check balance of msg.sender
        require(balance[msg.sender]>= amount,"ERROR 1_Insufficient balance to transfer funds.");
        require(msg.sender != recipient,"ERROR 2_The sender cannot be the recipient.");

        uint previousSenderBalance = balance[msg.sender];
        _transfer (msg.sender, recipient, amount);  
        assert(balance[msg.sender] == previousSenderBalance - amount); //event logs, further cheks, and error handling
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

}