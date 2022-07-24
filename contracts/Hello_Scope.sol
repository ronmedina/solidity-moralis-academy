// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;


contract HelloWorld {

// Contract Scope area
    string message = "Hello World";  

//Function scope (local vars)
    function hello() public view returns(string memory) {  
        return message; 
    }
}