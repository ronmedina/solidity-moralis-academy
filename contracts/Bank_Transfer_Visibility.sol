// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Bank{

    mapping (address => uint) balance;

    function addBalance (uint _toAdd) public returns (uint){
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }

    function getBalance () public view returns (uint){
        return balance[msg.sender];
    }

    function transfer(address recipient, uint amount) public {
        //INSERT check balance of msg.sender later

        _transfer (msg.sender, recipient, amount);

        //INSERT event logs, further cheks, and error handling later

    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

}