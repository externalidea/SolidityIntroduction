// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.2 < 0.9.0;

contract Subscription{
    uint subscriptionPrice = 1 ether;
    uint public duration = 30 days;
    address public owner;

    mapping(address => uint256) public subscriptionEnd;

    constructor () payable{
        owner = msg.sender;
    }
    function paySubscription() public payable {
        require(msg.value >= subscriptionPrice, "Not enough ETH sent");
        subscriptionEnd[msg.sender] = block.timestamp + duration;
    }
    function isActive(address user) public view returns(bool){
        return subscriptionEnd[user] > block.timestamp;
    }
}