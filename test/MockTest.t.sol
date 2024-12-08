// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import {PresaleTest} from "./PresaleTest.sol";

contract MockTest is PresaleTest {
    function setUp() public {
        fixture();
    }

    function test_get_sale_start_timestamp() public {
        assertEq(presale.saleStartTimestamp(), block.timestamp);
    }
}
