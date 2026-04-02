// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

/// @title ERC1155批量多资产合约
contract ERC1155BatchMint is ERC1155 {
    uint256 public tokenId;

    constructor() ERC1155("ipfs://Qmxxxx/{id}.json") {}

    function mintBatch(address to, uint256 amount) external {
        tokenId++;
        _mint(to, tokenId, amount, "");
    }

    function mintSingle(address to, uint256 id, uint256 amount) external {
        _mint(to, id, amount, "");
    }
}
