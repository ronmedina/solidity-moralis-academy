// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract HelloWorld {

    string message;

    constructor(string memory _message){ 
        message = _message;
    }

//Control Flow with normal operators, conditions, etc...
    function Hello(int number) public view returns(string memory){  
        if(number == 10){
            return message;
        } 
        else{   //can do elseif
            return "Wrong number";
        }
    }
}