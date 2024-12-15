// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { ERC20Sample } from "./samples/ERC20Sample.sol";

import { Test } from "./Test.sol";
import { IPresale } from "./interfaces/IPresale.sol";

contract PresaleTest is Test {
    IPresale public presale;

    ERC20Sample public token;

    function fixture() public {
        token = new ERC20Sample();

        presale = IPresale(deployCode("Presale", abi.encode(token, block.timestamp, block.timestamp + 1 days)));
    }
}
