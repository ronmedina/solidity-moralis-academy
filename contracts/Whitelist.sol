// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
import "openzeppelin's Whiteliest.sol";
//import "./Ownable.sol";


/**
 * @title Whitelist
 * @author Alberto Cuesta Canada
 * @dev Implements a simple whitelist of addresses.
 */
contract Whitelist is Ownable {
    event MemberAdded(address member);
    event MemberRemoved(address member);

    mapping (address => bool) members;

    /**
     * @dev The contract constructor.
     */
    constructor() payable Ownable() {
    }

    /**
     * @dev A method to verify whether an address is a member of the whitelist
     * @param _member The address to verify.
     * @return Whether the address is a member of the whitelist.
     */
    function isMember(address _member)
        public
        view
        returns(bool)
    {
        return members[_member];
    }

    /**
     * @dev A method to add a member to the whitelist
     * @param _member The member to add as a member.
     */
    function addMember(address _member)
        public
        payable
        onlyOwner
    {
        require(
            !isMember(_member),
            "Address is member already."
        );

        members[_member] = true;
        emit MemberAdded(_member);
    }

    /**
     * @dev A method to remove a member from the whitelist
     * @param _member The member to remove as a member.
     */
    function removeMember(address _member)
        public
        onlyOwner
    {
        require(
            isMember(_member),
            "Not member of whitelist."
        );

        delete members[_member];
        emit MemberRemoved(_member);
    }
}

