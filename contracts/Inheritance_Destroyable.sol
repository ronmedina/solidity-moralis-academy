// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./Ownable.sol";

//Self-Destruct and Inheritance

contract Destroyable is Ownable {

    function selfDestruct() public onlyOwner {
        selfdestruct(msg.sender);
    }
}