// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title BRC20铭文模拟铸造合约
/// @dev 适配铭文生态，支持mint、转账、余额查询
contract BRC20MintMachine {
    string public constant ticker = "ORDI";
    uint256 public constant maxSupply = 21_000_000 * 1e18;
    uint256 public mintPerTx = 1000 * 1e18;
    uint256 public totalMinted;
    
    mapping(address => uint256) public balanceOf;
    event Mint(address indexed to, uint256 amount);

    function mint() external {
        require(totalMinted + mintPerTx <= maxSupply, "Max supply");
        balanceOf[msg.sender] += mintPerTx;
        totalMinted += mintPerTx;
        emit Mint(msg.sender, mintPerTx);
    }

    function transfer(address to, uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "Insufficient");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
    }
}
