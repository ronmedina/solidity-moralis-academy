// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;


contract HelloWorld {

// Vars in this area are global
    string message = "Hello World";  

//Vars in the function area are local unless.  String memory.
    function hello() public view returns(string memory) {  
        return message; 
    }
}