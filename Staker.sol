// SPDX-License-Identifier: MIT
pragma solidity 0.8.4; //Do not change the solidity version as it negativly impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {
    event Stake(address sender, uint256 amount);

    ExampleExternalContract public exampleExternalContract;
    mapping(address => uint256) public balances;
    uint256 public constant THRESHOLD = 1 ether;
    uint public deadline = block.timestamp + 30 seconds;

    constructor(address exampleExternalContractAddress) {
        exampleExternalContract = ExampleExternalContract(
            exampleExternalContractAddress
        );
    }

    modifier clearDeadline() {
        require(block.timestamp < deadline, "Over Deadline!");
        _;
    }

    modifier overThreshold() {
        require(address(this).balance > THRESHOLD, "Not enough funds!");
        _;
    }

    modifier NotclearDeadline() {
        require(block.timestamp >= deadline, "Under Deadline!");
        _;
    }

    modifier NotoverThreshold() {
        require(address(this).balance <= THRESHOLD, "Cleared funds threshold!");
        _;
    }

    modifier NotCompleted() {
        require(
            !exampleExternalContract.completed(),
            "Staking already complete"
        );
        _;
    }

    // ( Make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )
    function stake() public payable NotCompleted {
        balances[msg.sender] += msg.value;
        emit Stake(msg.sender, msg.value);
    }

    // After some `deadline` allow anyone to call an `execute()` function
    // If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`
    function execute() public overThreshold NotCompleted {
        exampleExternalContract.complete{value: address(this).balance}();
    }

    // If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balance
    function withdraw() public NotoverThreshold {
        bool sent = payable(msg.sender).send(balances[msg.sender]);
        require(sent, "Could not withdraw!");
        balances[msg.sender] = 0;
    }

    // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
    function timeLeft() public view returns (uint256) {
        return block.timestamp >= deadline ? 0 : deadline - block.timestamp;
    }

    // Add the `receive()` special function that receives eth and calls stake()
    receive() external payable NotCompleted {
        stake();
    }
}
