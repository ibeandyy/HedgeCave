// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {LibClone} from "solady/utils/LibClone.sol";
import {Owned} from "solmate/auth/Owned.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";
import {HedgeContract} from "./HedgeContract.sol";

contract HedgeFactory is Owned {
    //Clone me instead, new instance per asset bls
    using LibClone for address;
    using SafeTransferLib for ERC20;

    event AssetAdded(address indexed asset);

    event AssetRemoved(address indexed asset);

    /// -----------------------------------------------------------------------
    /// Factory Storage
    /// -----------------------------------------------------------------------
    uint256 private contractCounter;
    bool public paused = false;
    address internal immutable HedgeContractImpl;
    mapping(address => address) public hedgeContracts;

    modifier assetExists(address _asset) {
        require(supportedAssets[_asset], "HedgeFactory: asset not supported");
        _;
    }

    constructor(address _impl) Owned(msg.sender) {
        HedgeContractImpl = _impl;
    }

    function createAsset() external notPaused returns (address) {}
    function enter() external notPaused {}
    function redeem() external notPaused {}
    function settle() external notPaused {}

    function removeAsset(address _asset) external {
        require(hedgeContracts[_asset], "HedgeFactory: asset not supported");
        selfdestruct(payable(_asset));
        hedgeContracts[_asset] = address(0);
        emit AssetRemoved(_asset);
    }
}
