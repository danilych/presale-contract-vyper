// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { IOwnable } from "./IOwnable.sol";

interface IPresale is IOwnable {
    function update_sale_start_timestamp(uint256 _sale_start_timestamp) external;

    function saleStartTimestamp() external view returns (uint256);

    function saleEndTimestamp() external view returns (uint256);

    function token() external view returns (IERC20);

    event SaleStartTimestampIsUpdated(uint256 newSaleStartTimestamp);
    event SaleEndTimestampIsUpdated(uint256 newSaleEndTimestamp);
    event TokenIsUpdated(IERC20 newToken);
}
