// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Task2 {
    struct User {
        string name;
        uint256 age;
        uint256 balance;
    }

    address public immutable i_owner;
    mapping(address => User) public addressToUser;

    constructor() {
        i_owner = msg.sender;
    }

    function deposit(uint256 depositAmount) public {
        addressToUser[i_owner].balance += depositAmount;
    }

    function checkBalance() public view returns (uint256) {
        return addressToUser[i_owner].balance;
    }

    function setUserDetails(string calldata name, uint256 age) public {
        User memory user;
        user.name = name;
        user.age = age;
        user.balance = checkBalance();
        addressToUser[i_owner] = user;
    }

    function getUserDetails()
        public
        view
        returns (
            string memory,
            uint256,
            uint256
        )
    {
        return (
            addressToUser[i_owner].name,
            addressToUser[i_owner].age,
            addressToUser[i_owner].balance
        );
    }
}
