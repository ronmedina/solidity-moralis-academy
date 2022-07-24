// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
// DATA LOCATION

contract Hello{
    // storage - persistant data storage
    // memory - temporary data storage until function finishes (value data types like uint, boolean, etc..)
    // calldata - similar to memory, but READ-ONLY to optimizes gas/trans, doesn't use as much memory

    //state variables are stored in storage ""
    uint data = 123; //state var 
    string lastText; //state var

    function getString(string memory text) pure public returns(string memory){
        // lastText = text (lastText is a state variable
        // uint 2ndNumber = 10 (vars declared in functions are stored in memory
        return text; // text is erased after function finishes
    }

    function setString(string memory text) public{
        string memory newString = lastText;
        newString = text; //does not change the state var
        lastText = text;  //changes the state var
    }
}