// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IOwnable} from "./IOwnable.sol";

interface IPresale is IOwnable {
    function update_sale_start_timestamp(uint256 _sale_start_timestamp) external;

    function saleStartTimestamp() external view returns (uint256);
}