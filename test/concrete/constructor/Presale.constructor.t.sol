// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { IPresale } from "test/interfaces/IPresale.sol";
import { PresaleTest } from "test/PresaleTest.sol";

contract PresaleConstructor is PresaleTest {
    function setUp() public {
        fixture();
    }

    function test_WhenTokenIsAddressZero() external {
        // it reverts
        vm.expectRevert("Invalid token address");
        deployCode("Presale", abi.encode(address(0), block.timestamp, block.timestamp + 1 days));
    }

    function test_WhenSaleStartTimestampIsGreaterThanSaleEndTimestamp() external {
        // it reverts
        vm.expectRevert("Invalid sale timestamps");
        deployCode("Presale", abi.encode(token, block.timestamp + 1 days, block.timestamp));
    }

    function test_WhenSaleStartTimestampLessThanBlockTimestamp() external {
        // it reverts
        vm.expectRevert("Invalid start timestamp");
        deployCode("Presale", abi.encode(token, block.timestamp - 1, block.timestamp + 1 days));
    }

    function test_WhenOwnerIsNotAddressZeroAndTokenIsNotAddressZeroAndSaleStartTimestampIsLessThanSaleEndTimestamp()
        external
    {
        // it emits SaleStartTimestampIsUpdated with newSaleStartTimestamp as saleStartTimestamp
        vm.expectEmit(true, true, true, true);
        emit IPresale.SaleStartTimestampIsUpdated(block.timestamp);

        // it emits SaleEndTimestampIsUpdated with newSaleEndTimestamp as saleEndTimestamp
        vm.expectEmit(true, true, true, true);
        emit IPresale.SaleEndTimestampIsUpdated(block.timestamp + 1 days);

        // it emits TokenIsUpdated with newToken as token
        vm.expectEmit(true, true, true, true);
        emit IPresale.TokenIsUpdated(token);

        vm.prank(deployer);
        IPresale presale = IPresale(deployCode("Presale", abi.encode(token, block.timestamp, block.timestamp + 1 days)));

        // it initializes ownable
        assertEq(presale.owner(), deployer);

        // it sets saleStartTimestamp to saleStartTimestamp
        assertEq(presale.schedule().saleStartTimestamp, block.timestamp);

        // it sets saleEndTimestamp to saleEndTimestamp
        assertEq(presale.schedule().saleEndTimestamp, block.timestamp + 1 days);

        // it sets token to token
        assertEq(address(presale.token()), address(token));
    }
}
