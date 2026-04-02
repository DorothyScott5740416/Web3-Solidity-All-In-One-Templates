// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/// @title NFT荷兰式拍卖（价格自动递减）
contract NFTDutchAuction {
    IERC721 public nft;
    uint256 public tokenId;
    address public seller;
    uint256 public startPrice;
    uint256 public endPrice;
    uint256 public duration;
    uint256 public startTime;

    constructor(address _nft, uint256 _id, uint256 _sPrice, uint256 _ePrice, uint256 _dur) {
        nft = IERC721(_nft); tokenId = _id; seller = msg.sender;
        startPrice = _sPrice; endPrice = _ePrice; duration = _dur;
        startTime = block.timestamp;
    }

    function getCurrentPrice() public view returns(uint256) {
        if (block.timestamp >= startTime + duration) return endPrice;
        uint256 decay = (startPrice - endPrice) * (block.timestamp - startTime) / duration;
        return startPrice - decay;
    }

    function buy() external payable {
        uint256 price = getCurrentPrice();
        require(msg.value >= price, "Not enough");
        nft.transferFrom(seller, msg.sender, tokenId);
        payable(seller).transfer(address(this).balance);
    }
}
