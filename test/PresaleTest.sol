// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

interface IPresale {
    function update_sale_start_timestamp(uint256 _sale_start_timestamp) external;

    function saleStartTimestamp() external view returns (uint256);
}

contract PresaleTest is Test {
    IPresale public presale;

    function fixture() public {
        presale = IPresale(
            deployCode("Presale", abi.encode(address(10), address(30), block.timestamp, block.timestamp + 100))
        );
    }
}
