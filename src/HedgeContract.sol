// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

enum ContractState {
    PENDING,
    ACTIVE,
    EXPIRED,
    SETTLED
}

struct Contract {
    uint256 contractId;
    address party;
    address counterparty;
    address token;
    uint256 tokenAmount;
    uint256 startPPS;
    uint256 startTime;
    ContractState state;
    uint256 endPPS;
    uint256 expiryTime;
}

contract HedgeContract {
    Contract[] public contracts;

    event ContractCreated(
        uint256 indexed ContractId,
        address indexed currency,
        address trueTokens,
        address falseTokens,
        uint256 strike,
        uint256 maturity
    );
    event ContractEntered(uint256 indexed ContractId, address indexed caller, uint256 amount0, uint256 amount1);

    event ContractRedemption(uint256 indexed ContractId, address indexed caller, uint256 amountIn, uint256 amountOut);

    event ContractSettled(uint256 indexed ContractId, uint256 roundId, int256 answer);

    function initialize() external {}
}
