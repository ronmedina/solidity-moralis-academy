// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
//FOR LOOP

contract Hello {

    function count(int number) public pure returns(int){
        for(int i=0; i<10; i++){
            number++;
        }  
    return number;
    }
}