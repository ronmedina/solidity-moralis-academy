// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
/**STRUCT allows you to create your own data type in the form of structure.  You can 
 * define properties of an object like Person
*/ 

contract Struct{

    struct Person{
        uint age;
        string name;
        uint weight;
        }

    Person[] people;

    function addPerson(uint _age, string memory _name, uint _weight) public {
        Person memory newPerson = Person(_age, _name, _weight);
        people.push(newPerson);
        }
    function getPerson(uint _index) public view returns (uint, string memory, uint){
        Person memory personToReturn = people[_index];
        return (personToReturn.age, personToReturn.name, personToReturn.weight);
        }
}