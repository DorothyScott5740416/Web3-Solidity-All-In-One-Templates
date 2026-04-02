// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title 线性代币锁仓释放
/// @dev 按时间线性解锁，防止一次性砸盘
contract LinearVestingWallet {
    IERC20 public immutable token;
    address public beneficiary;
    uint256 public start;
    uint256 public duration = 365 days;
    uint256 public released;

    constructor(address _token, address _beneficiary) {
        token = IERC20(_token);
        beneficiary = _beneficiary;
        start = block.timestamp;
    }

    function release() external {
        require(msg.sender == beneficiary, "Not beneficiary");
        uint256 total = vestedAmount();
        uint256 payout = total - released;
        require(payout > 0, "No payout");
        released += payout;
        token.transfer(beneficiary, payout);
    }

    function vestedAmount() public view returns(uint256) {
        uint256 total = token.balanceOf(address(this));
        if (block.timestamp >= start + duration) return total;
        return total * (block.timestamp - start) / duration;
    }
}
