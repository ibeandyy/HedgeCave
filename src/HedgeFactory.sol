// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {LibClone} from "solady/utils/LibClone.sol";
import {Owned} from "solmate/auth/Owned.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";

struct Contract {
    uint256 contractId;
    address party;
    address counterparty;
    address token;
    uint256 startRate;
    uint256 startTime;
    ContractState state;
    uint256 endRate;
    uint256 expiryTime;
}

enum ContractState {
    PENDING,
    ACTIVE,
    EXPIRED,
    SETTLED
}

contract HedgeFactory is Owned {
    using LibClone for address;

    using SafeTransferLib for ERC20;

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

    /// -----------------------------------------------------------------------
    /// Factory Storage
    /// -----------------------------------------------------------------------

    Market[] public markets;

    address internal immutable ContrastERC20Singleton;
}
