// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Mappings{
// MAPPING key to value
    mapping(address => uint) balance;
    
    function addBalance(uint _toAdd) public returns (uint) { //not view or pure because mapping will be modified
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
        }

    function getBalance() public view returns (uint){
        return balance [msg.sender];
        }
}