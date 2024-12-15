// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

interface IOwnable {
    function owner() external view returns (address);

    function transfer_ownership(address newOwner) external;

    function renounce_ownership() external;
}   