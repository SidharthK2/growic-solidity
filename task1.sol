// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

error Task1__NotOwner();
error Task1__AlreadyRegistered();

contract Task1 {
    struct Student {
        uint8 percentage;
        uint256 totalMarks;
        bool registered;
    }

    address public immutable i_owner;
    mapping(address => Student) public studentToDetails;

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert Task1__NotOwner();
        _;
    }

    constructor() {
        i_owner = msg.sender;
    }

    function registerStudent(
        address studentId,
        uint8 studentPercentage,
        uint256 studentTotalMarks
    ) public onlyOwner {
        if (studentToDetails[studentId].registered) {
            revert Task1__AlreadyRegistered();
        }
        Student memory student;
        student.percentage = studentPercentage;
        student.totalMarks = studentTotalMarks;
        student.registered = true;
        studentToDetails[studentId] = student;
    }

    function getStudentDetails(address studentId)
        public
        view
        returns (uint8, uint256)
    {
        return (
            studentToDetails[studentId].percentage,
            studentToDetails[studentId].totalMarks
        );
    }
}
l
