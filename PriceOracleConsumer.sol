// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title 链上价格预言机
/// @dev 模拟Chainlink喂价，获取代币/ETH实时汇率
contract PriceOracleConsumer {
    address public immutable owner;
    mapping(string => uint256) public tokenPrices; // 价格: 1e18 = 1 ETH

    constructor() { owner = msg.sender; }

    modifier onlyOwner() { require(msg.sender == owner); _; }

    /// @notice 管理员更新价格（模拟预言机）
    function updatePrice(string calldata symbol, uint256 price) external onlyOwner {
        tokenPrices[symbol] = price;
    }

    /// @notice 获取最新价格
    function getLatestPrice(string calldata symbol) external view returns(uint256) {
        return tokenPrices[symbol];
    }
}
