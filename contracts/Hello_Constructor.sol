pragma solidity 0.8.13;

contract HelloWorld {

// State vars preserves globally.
    string message;

//Constructor initializes contract at the time deployed.
    constructor(string memory _message){  
        message = _message;
    }

    function Hello() public view returns(string memory){  
            return message;
        }
} 