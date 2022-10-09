// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Task2 {
    address public immutable i_owner;
    mapping(address => uint256) public addressToBalance;

    constructor() {
        i_owner = msg.sender;
    }

    function deposit(uint256 depositAmount) public {
        addressToBalance[i_owner] += depositAmount;
    }
}
