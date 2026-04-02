// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title 闪电贷基础执行模板
contract FlashLoanTemplate {
    IERC20 public immutable loanToken;

    constructor(address _token) { loanToken = IERC20(_token); }

    /// @notice 闪电贷执行逻辑（需对接 lending pool）
    function executeFlashLoan(uint256 amount) external {
        uint256 balanceBefore = loanToken.balanceOf(address(this));
        
        // 借贷逻辑
        require(loanToken.transferFrom(msg.sender, address(this), amount));
        
        // 自定义策略：套利/清算
        uint256 balanceAfter = loanToken.balanceOf(address(this));
        require(balanceAfter >= balanceBefore, "Loss");

        loanToken.transfer(msg.sender, amount);
    }
}
