// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { IPresale } from "test/interfaces/IPresale.sol";
import { PresaleTest } from "test/PresaleTest.sol";

contract PresaleUpdateSaleEndTimestamp is PresaleTest {
    function setUp() public {
        vm.startPrank(deployer);
        fixture();
        vm.stopPrank();
    }

    function test_WhenCallerIsNotOwner() external {
        // it reverts
        vm.prank(alice);
        vm.expectRevert("ownable: caller is not the owner");
        presale.update_sale_end_timestamp(block.timestamp + 2 days);
    }

    function test_WhenNewEndTimestampIsLowerThanStartTimestamp() external {
        // it reverts
        vm.startPrank(deployer);
        uint256 startTimestamp = presale.schedule().saleStartTimestamp;
        vm.expectRevert(bytes("New end timestamp is lower than start timestamp"));
        presale.update_sale_end_timestamp(startTimestamp - 1);
        vm.stopPrank();
    }

    function test_WhenCallerIsOwnerAndNewEndTimestampIsHigherThanStartTimestamp() external {
        uint256 newEndTimestamp = block.timestamp + 2 days;
        
        // it emits SaleEndTimestampIsUpdated with newSaleEndTimestamp
        vm.expectEmit(true, true, true, true);
        emit IPresale.SaleEndTimestampIsUpdated(newEndTimestamp);

        // when owner calls update_sale_end_timestamp
        vm.startPrank(deployer);
        presale.update_sale_end_timestamp(newEndTimestamp);
        vm.stopPrank();

        // it updates saleEndTimestamp
        assertEq(presale.schedule().saleEndTimestamp, newEndTimestamp);
    }
}
