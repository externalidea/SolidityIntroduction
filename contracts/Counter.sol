// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.2 < 0.9.0;

contract Counter {
    uint256 counter = 0;

    function increase() public {
        counter += 1;
    }

    function decrease() public {
        counter -= 1;
    }

    function getCounter() public view returns (uint256) {
        return counter;
    }
}