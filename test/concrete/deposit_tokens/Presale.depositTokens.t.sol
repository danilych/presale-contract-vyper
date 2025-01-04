// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import {PresaleTest} from "../../PresaleTest.sol";
import {IPresale} from "../../interfaces/IPresale.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PresaledepositTokens is PresaleTest {
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
        assertEq(presale.liquidity(), amount, "Liquidity not updated");

        vm.stopPrank();
    }

    function test_WhenTokenTransferIsNotSuccessful() external {
        // it reverts
        uint256 amount = 100 ether;
        
        // Try to deposit without approval
        vm.prank(deployer);
        vm.expectRevert(abi.encodeWithSignature("ERC20InsufficientAllowance(address,uint256,uint256)", address(presale), 0, amount));
        presale.deposit_tokens(amount);
    }
}
