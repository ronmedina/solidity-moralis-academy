// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
//SETTER FUNCTION allow you to set state variables

contract Hello {
    int number;

    function getNumber() public view returns(int){
        return number;
        }
    function setNumber(int _number) public {  //not view or pure because we are changing the state of "number"
        number = _number;

    }

}