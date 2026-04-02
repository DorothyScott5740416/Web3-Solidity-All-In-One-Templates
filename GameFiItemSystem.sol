// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title GameFi链上装备系统
contract GameFiItemSystem {
    struct Item {
        uint256 level;
        uint256 power;
        bool exists;
    }

    mapping(uint256 => Item) public items;
    mapping(address => uint256[]) public userItems;
    uint256 public itemId;

    function craftItem() external {
        itemId++;
        items[itemId] = Item(1, 100, true);
        userItems[msg.sender].push(itemId);
    }

    function upgradeItem(uint256 id) external {
        require(items[id].exists, "Not exist");
        items[id].level++;
        items[id].power += 50;
    }

    function getUserItemCount(address user) external view returns(uint256) {
        return userItems[user].length;
    }
}
