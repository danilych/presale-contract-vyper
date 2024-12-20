// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { IPresale } from "test/interfaces/IPresale.sol";
import { PresaleTest } from "test/PresaleTest.sol";

contract PresaleUpdateSaleStartTimestamp is PresaleTest {
    function setUp() public {
        vm.startPrank(deployer);
        fixture();
        vm.stopPrank();
    }

    function test_WhenCallerIsNotOwner() external {
        // it reverts
        vm.prank(alice);
        vm.expectRevert("ownable: caller is not the owner");
        presale.update_sale_start_timestamp(block.timestamp + 2 days);
    }

    function test_WhenNewStartTimestampIsGreaterThanEndTimestamp() external {
        // it reverts
        vm.startPrank(deployer);
        uint256 endTimestamp = presale.saleEndTimestamp();
        vm.expectRevert(bytes("New start timestamp is higher than end timestamp"));
        presale.update_sale_start_timestamp(endTimestamp + 1);
        vm.stopPrank();
    }

    function test_WhenCallerIsOwnerAndNewStartTimestampIsLessThanEndTimestamp() external {
        uint256 newStartTimestamp = block.timestamp + 12 hours;
        
        // it emits SaleStartTimestampIsUpdated with newSaleStartTimestamp
        vm.expectEmit(true, true, true, true);
        emit IPresale.SaleStartTimestampIsUpdated(newStartTimestamp);

        // when owner calls update_sale_start_timestamp
        vm.startPrank(deployer);
        presale.update_sale_start_timestamp(newStartTimestamp);
        vm.stopPrank();

        // it updates saleStartTimestamp
        assertEq(presale.saleStartTimestamp(), newStartTimestamp);
    }
}
