// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AttendanceSystem {
    address public owner;

    struct Student {
        string name;
        bool isRegistered;
    }

    mapping(address => Student) public students;
    mapping(address => mapping(string => bool)) public attendance; // student => date => present

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    modifier onlyRegistered() {
        require(students[msg.sender].isRegistered, "Not registered");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerStudent(address _studentAddress, string memory _name) public onlyOwner {
        students[_studentAddress] = Student(_name, true);
    }

    function markAttendance(address _studentAddress, string memory _date) public onlyOwner {
        require(students[_studentAddress].isRegistered, "Student not registered");
        attendance[_studentAddress][_date] = true;
    }

    function checkAttendance(address _studentAddress, string memory _date) public view returns (bool) {
        return attendance[_studentAddress][_date];
    }
}
