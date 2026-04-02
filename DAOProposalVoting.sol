// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title DAO链上治理投票系统
contract DAOProposalVoting {
    struct Proposal {
        string description;
        uint256 voteFor;
        uint256 voteAgainst;
        bool executed;
        uint256 endTime;
    }

    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;
    address public immutable owner;

    constructor() { owner = msg.sender; }

    function createProposal(string calldata desc, uint256 voteDays) external {
        proposals.push(Proposal(desc, 0, 0, false, block.timestamp + voteDays * 1 days));
    }

    function vote(uint256 id, bool support) external {
        require(!hasVoted[msg.sender], "Voted");
        require(block.timestamp < proposals[id].endTime, "Ended");
        support ? proposals[id].voteFor++ : proposals[id].voteAgainst++;
        hasVoted[msg.sender] = true;
    }

    function executeProposal(uint256 id) external {
        Proposal storage p = proposals[id];
        require(block.timestamp >= p.endTime && !p.executed, "Cannot exec");
        require(p.voteFor > p.voteAgainst, "Rejected");
        p.executed = true;
    }
}
