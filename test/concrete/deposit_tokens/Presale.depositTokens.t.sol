// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { PresaleTest } from "../../PresaleTest.sol";
import { IPresale } from "../../interfaces/IPresale.sol";

contract PresaleDepositTokensTest is PresaleTest {
    function setUp() public {
        vm.startPrank(deployer);
        fixture();
        vm.stopPrank();
    }

    function test_WhenSaleIsAlreadyStarted() external {
        // it reverts
        vm.startPrank(deployer);
        vm.warp(presale.saleStartTimestamp() + 1);
        vm.expectRevert("Sale is already started");
        presale.deposit_tokens(1 ether);
        vm.stopPrank();
    }

    function test_WhenNotOwnerTryToDepositTokens() external {
        // it reverts
        vm.prank(alice);
        vm.expectRevert("ownable: caller is not the owner");
        presale.deposit_tokens(1 ether);
    }

    function test_WhenAmountIsZero() external {
        // it reverts
        vm.prank(deployer);
        vm.expectRevert("Amount must be greater than 0");
        presale.deposit_tokens(0);
    }

    function test_WhenOwnerDepositTokens() external {
        uint256 amount = 100 ether;
        
        // Setup token approval
        vm.startPrank(deployer);
        token.approve(address(presale), amount);
        
        // it transfers tokens
        uint256 balanceBefore = token.balanceOf(address(presale));

        // it emits
        vm.expectEmit(true, true, true, true);
        emit IPresale.TokensDeposited(deployer, amount);
        
        presale.deposit_tokens(amount);
        uint256 balanceAfter = token.balanceOf(address(presale));
        
        // it updates balance
        assertEq(balanceAfter - balanceBefore, amount, "Token balance not updated correctly");
        
        // it state is updated - tokens are transferred from owner to presale
        assertEq(token.balanceOf(address(presale)), amount, "Presale balance not updated");
        
        vm.stopPrank();
    }
}
