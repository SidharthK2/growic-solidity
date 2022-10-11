// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Task2 {
    struct User {
        string name;
        uint256 age;
    }

    address public immutable i_owner;
    mapping(address => uint256) public addressToBalance;

    constructor() {
        i_owner = msg.sender;
    }

    function deposit(uint256 depositAmount) public {
        addressToBalance[i_owner] += depositAmount;
    }

    function checkBalance() public view returns (uint256) {
        return addressToBalance[i_owner];
    }

    function setUserDetails(string calldata name, uint256 age) public {
        user memory User;
        user.name = name;
        user.age = age;
    }

    function getUserDetails() public view returns (string, uint256) {
        return (user.name, user.age);
    }
}
