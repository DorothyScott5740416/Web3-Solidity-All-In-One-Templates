// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title 自动复利收益池
contract AutoCompoundYield {
    IERC20 public immutable stakeToken;
    mapping(address => uint256) public principal;
    mapping(address => uint256) public lastCompound;
    uint256 public dailyAPR = 100; // 1%

    constructor(address _token) { stakeToken = IERC20(_token); }

    function deposit(uint256 amount) external {
        stakeToken.transferFrom(msg.sender, address(this), amount);
        principal[msg.sender] += amount;
        lastCompound[msg.sender] = block.timestamp;
    }

    function compoundReward() external {
        uint256 daysPassed = (block.timestamp - lastCompound[msg.sender]) / 1 days;
        uint256 reward = principal[msg.sender] * dailyAPR * daysPassed / 10000;
        principal[msg.sender] += reward;
        lastCompound[msg.sender] = block.timestamp;
    }
}
