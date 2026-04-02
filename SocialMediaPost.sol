// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title 链上去中心化社交发帖
contract SocialMediaPost {
    struct Post {
        address author;
        string content;
        uint256 timestamp;
    }

    Post[] public posts;
    event PostCreated(address indexed author, string content, uint256 time);

    function publishPost(string calldata content) external {
        posts.push(Post(msg.sender, content, block.timestamp));
        emit PostCreated(msg.sender, content, block.timestamp);
    }

    function getPostCount() external view returns(uint256) {
        return posts.length;
    }
}
