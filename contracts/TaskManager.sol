// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.2 < 0.9.0;

contract taskManager {
    string[] public tasks;
    function createTask (string memory task) public {
        tasks.push(task);
    }
    function removeTask (uint index) public {
        require(index < tasks.length, "Index out of range");
        for (uint i = index; i < tasks.length - 1; i++)
            tasks [i] = tasks[i + 1];
        tasks.pop();
    }
    function getTasks () view public returns (string[] memory){
        return tasks;
    }
}