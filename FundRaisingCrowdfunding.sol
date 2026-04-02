// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title 去中心化众筹平台
contract FundRaisingCrowdfunding {
    address public creator;
    uint256 public goal;
    uint256 public endTime;
    uint256 public totalRaised;
    mapping(address => uint256) public donations;

    constructor(uint256 _goal, uint256 _days) {
        creator = msg.sender;
        goal = _goal;
        endTime = block.timestamp + _days * 1 days;
    }

    function donate() external payable {
        require(block.timestamp < endTime, "Ended");
        donations[msg.sender] += msg.value;
        totalRaised += msg.value;
    }

    function withdraw() external {
        require(msg.sender == creator && totalRaised >= goal, "Not allowed");
        payable(creator).transfer(address(this).balance);
    }

    function refund() external {
        require(block.timestamp >= endTime && totalRaised < goal, "No refund");
        uint256 amount = donations[msg.sender];
        donations[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
