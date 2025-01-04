// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { IOwnable } from "./IOwnable.sol";

interface IPresale is IOwnable {
    struct Schedule {
        uint256 saleStartTimestamp;
        uint256 saleEndTimestamp;
    }

    function update_sale_start_timestamp(uint256 _sale_start_timestamp) external;

    function update_sale_end_timestamp(uint256 _sale_end_timestamp) external;

    function deposit_tokens(uint256 amount) external;

    function schedule() external view returns (Schedule memory);

    function token() external view returns (IERC20);
    
    function liquidity() external view returns (uint256);

    event SaleStartTimestampIsUpdated(uint256 newSaleStartTimestamp);
    event SaleEndTimestampIsUpdated(uint256 newSaleEndTimestamp);
    event TokenIsUpdated(IERC20 newToken);
    event TokensDeposited(address indexed from_, uint256 amount);
}
