// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title 带黑名单管控的合规ERC20
contract BlacklistGuardToken {
    mapping(address => uint256) public balanceOf;
    mapping(address => bool) public blacklisted;
    string public name = "GuardToken";
    string public symbol = "GUARD";
    uint8 public decimals = 18;
    address public immutable owner;

    constructor() { owner = msg.sender; balanceOf[owner] = 1e8 * 1e18; }

    modifier onlyOwner() { require(msg.sender == owner); _; }
    modifier notBlacklisted() { require(!blacklisted[msg.sender]); _; }

    function setBlacklist(address account, bool status) external onlyOwner {
        blacklisted[account] = status;
    }

    function transfer(address to, uint256 amount) external notBlacklisted returns(bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }
}
