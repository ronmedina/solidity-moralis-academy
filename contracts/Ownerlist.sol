// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
/**
 * @title Ownerlist
 * @author Superior Blocks
 * @dev List of owner addresses based on @openzeppelin/contracts/ownership/Ownable.sol
 */


//Inheritance - Parent-child relationships
import "./Ownable.sol";

contract Ownerlist is Ownable {
    event OwnerAdded(address owner);
    event OwnerRemoved(address owner);

    mapping (address => bool) owners;

    modifier onlyOwners {
        require(isOwner(msg.sender), "ERROR: You are not an owner and not allowed."); // fail hard
        _;
    }    

    /**
    * @dev Visibility (public / external) is not needed for constructors anymore: 
    * To prevent a contract from being created, it can be marked abstract. 
    */
    constructor() Ownable() { 
    }

    /**
     * @dev A method to verify whether an address is a owner on the Ownerlist
     * @param _owner The address to verify.
     * @return Whether the address is in the Ownerlist.
     */
    function isOwner(address _owner) public view returns(bool)
    {
        return owners[_owner];
    }

    /**
     * @dev A method to add an address to the Ownerlist
     * @param _owner The address to add as a owner.
     */
    function addOwners(address _owner) public onlyOwner 
    {
        require(
            !isOwner(_owner),
            "Address is owner already."
        );

        owners[_owner] = true;
        emit OwnerAdded(_owner);
    }

    /**
     * @dev A method to remove a owner from the Ownerlist
     * @param _owner The address to remove as a owner.
     */
    function removeOwners(address _owner) public onlyOwner
    {
        require(
            isOwner(_owner),
            "Not owner of ownerlist."
        );

        delete owners[_owner];
        emit OwnerRemoved(_owner);
    }
}