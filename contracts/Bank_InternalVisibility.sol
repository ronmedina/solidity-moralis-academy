// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

//Inheritance - Parent-child relationships
import "./Ownable.sol";
import "./Inheritance_Destroyable.sol";

contract Bank_Inheritance is Ownable, Destroyable {

    mapping (address => uint) balance;

    //event logs
    event deposited (uint indexed amount, address indexed depositedTo);
    event transferedAmount(address indexed from, address indexed to, uint indexed amount);


    function deposit() public onlyOwner payable returns (uint) { 
        balance[msg.sender] += msg.value; // just keeps track of internal balances & no longer needed because we don't need to track internal balances
        emit deposited (msg.value, msg.sender);      //log event
        return balance[msg.sender];
    }

    function getOwner() public view returns (address){
        return owner;
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