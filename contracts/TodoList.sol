// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract TodoList {
    address public owner;
    struct ToDo {
        string description;
        bool completed;
    }

    mapping(address => ToDo[]) private todos;
    mapping(string => bool) private added;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function create(string calldata _description) public onlyOwner {
        if (added[_description]) revert ("already added");

        todos[owner].push(ToDo(_description, false));
        added[_description] = true;
    }

    function update(uint _index, string memory _description) external onlyOwner {
        ToDo storage item = todos[owner][_index];
        item.description = _description;
        added[_description] = false;
    }
    
    function get(uint _index) external view onlyOwner returns (ToDo memory) {
        return todos[owner][_index];
    }

    function getAll() external view returns (ToDo[] memory) {
        return todos[owner];
    }

    function toggleCompleted(uint _index) external onlyOwner {
        ToDo storage item = todos[owner][_index];
        item.completed = !item.completed;
    }
}