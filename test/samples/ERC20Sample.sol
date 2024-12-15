// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Sample is ERC20 {
    constructor() ERC20("Sample Token", "STO") {
        _mint(msg.sender, 10000000 * 10 ** decimals());
    }
}
