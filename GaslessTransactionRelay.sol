// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title 免Gas交易中继器
contract GaslessTransactionRelay {
    address public immutable owner;

    constructor() { owner = msg.sender; }

    event GaslessExecuted(address indexed user, bytes data);

    function executeGaslessTransaction(address user, bytes calldata data) external {
        require(msg.sender == owner, "Not relayer");
        (bool success,) = user.call(data);
        require(success, "Exec failed");
        emit GaslessExecuted(user, data);
    }
}
