// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title 链上加密消息存储
contract EncryptedMessageStorage {
    struct Message {
        address sender;
        bytes encryptedData;
        uint256 time;
    }

    mapping(address => Message[]) public userMessages;
    event MessageStored(address indexed user, bytes data);

    function sendEncryptedMessage(bytes calldata data) external {
        userMessages[msg.sender].push(Message(msg.sender, data, block.timestamp));
        emit MessageStored(msg.sender, data);
    }

    function getMessageCount(address user) external view returns(uint256) {
        return userMessages[user].length;
    }
}
