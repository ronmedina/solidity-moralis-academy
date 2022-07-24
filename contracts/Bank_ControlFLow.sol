// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract If_Else {

    string message;

    constructor(string memory _message) {
        message = _message;
    }

    function Bank() public view returns(string memory){  //Functions can be buttons on the web page
        
        if(msg.sender == 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2){
            return message;
        } 
        else{
            return "Wrong Address";
        }
    }
}