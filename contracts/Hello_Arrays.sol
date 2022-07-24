// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

/** ARRAY - An array allows us to represent a collection of data, but it is often more
 * useful to think of an array as a collection of variables of the same type with keys
 * having sequential order based off the order they were added.
 *
 * @title Array
 * @author Superior Blocks
 * @dev Simple example of an array.
*/

contract Array {

    int[] numbers;

    function addNumber(int _number) public {
        numbers.push(_number);
        }

    function getNumber(uint _index) public view returns(int){
        return numbers[_index];
        }

    function getArray() public view returns(int[] memory){
        return numbers;
        }
}