// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from './Test.sol';

import {IPresale} from './interfaces/IPresale.sol';

contract PresaleTest is Test {
	IPresale public presale;

	function fixture() public {
		presale = IPresale(deployCode('Presale', abi.encode(address(10), address(30), block.timestamp, block.timestamp + 100)));
	}
}
