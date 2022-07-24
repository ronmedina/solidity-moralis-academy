// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
//Error Handling using Require & Assert

contract Bank_Require{

    mapping (address => uint) balance;
    address owner; //state variable

    constructor(){
        owner = msg.sender; //admin or owner privleges
    }

    function addBalance (uint _toAdd) public returns (uint){ 
        //For higher permissions like only employees or owner of bank can add
        require(msg.sender == owner);
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }

    function getBalance () public view returns (uint){
        return balance[msg.sender];
    }

    function transfer(address recipient, uint amount) public {
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