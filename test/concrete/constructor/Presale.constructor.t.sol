// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { PresaleTest } from "test/PresaleTest.sol";

contract PresaleConstructorTest is PresaleTest {
    function setUp() public {
        fixture();
    }

    function test_WhenTokenIsAddressZero() external {
        // it reverts
    }

    function test_WhenSaleStartTimestampIsGreaterThanSaleEndTimestamp() external {
        // it reverts
    }

    function test_WhenOwnerIsNotAddressZeroAndTokenIsNotAddressZeroAndSaleStartTimestampIsLessThanSaleEndTimestamp()
        external
    {
        // it initializes ownable
        // it sets saleStartTimestamp to saleStartTimestamp
        // it sets saleEndTimestamp to saleEndTimestamp
        // it sets token to token
        // it emits SaleStartTimestampIsUpdated with newSaleStartTimestamp as saleStartTimestamp
        // it emits SaleEndTimestampIsUpdated with newSaleEndTimestamp as saleEndTimestamp
        // it emits TokenIsUpdated with newToken as token
    }
}
