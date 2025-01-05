// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { IPresale } from "test/interfaces/IPresale.sol";
import { PresaleTest } from "test/PresaleTest.sol";

contract PresaleWithdrawTokens is PresaleTest {
    function setUp() public {
        vm.startPrank(deployer);
        fixture();
        
        // Deposit some tokens first
        token.approve(address(presale), 100 ether);
        presale.deposit_tokens(100 ether);
        
        vm.stopPrank();
    }

    function test_WhenAmountIsZero() external {
        // it reverts
        vm.prank(deployer);
        vm.expectRevert("Amount must be greater than 0");
        presale.withdraw_tokens(0);
    }

    function test_WhenCallerIsNotOwner() external {
        // it reverts
        vm.prank(alice);
        vm.expectRevert("ownable: caller is not the owner");
        presale.withdraw_tokens(1 ether);
    }

    function test_WhenCallerIsOwnerAndNotEnoughLiquidity() external {
        // it reverts
        vm.prank(deployer);
        vm.expectRevert("Not enough liquidity");
        presale.withdraw_tokens(101 ether);
    }

    function test_WhenCallerIsOwnerAndEnoughLiquidity() external {
        uint256 amount = 50 ether;
        
        // it emits TokensWithdrawn with owner and amount
        vm.expectEmit(true, true, true, true);
        emit IPresale.TokensWithdrawn(deployer, amount);

        uint256 ownerBalanceBefore = token.balanceOf(deployer);
        uint256 presaleBalanceBefore = token.balanceOf(address(presale));
        uint256 liquidityBefore = presale.liquidity();

        // when owner calls withdraw_tokens
        vm.prank(deployer);
        presale.withdraw_tokens(amount);

        // it transfers tokens from presale to owner
        assertEq(token.balanceOf(deployer) - ownerBalanceBefore, amount, "Owner balance not updated correctly");
        assertEq(presaleBalanceBefore - token.balanceOf(address(presale)), amount, "Presale balance not updated correctly");

        // it updates liquidity
        assertEq(liquidityBefore - presale.liquidity(), amount, "Liquidity not updated correctly");
    }
}
