// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Ownable{

    //State variable(s)  using internal instead of private
    address internal owner;

    //Modifier(s) - for restricting permissions like "only employees", "admins", or "owner" etc...
    modifier onlyOwner {
        require(msg.sender == owner);  
        _;
    }

    // Constructor used to initialize var
    constructor(){
        owner = msg.sender; 
    }
}