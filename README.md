# Presale Smart Contract Vyper Edition

![Solidity](https://img.shields.io/badge/-Solidity-090909?style=for-the-badge&logo=solidity)
![Foundry](https://img.shields.io/badge/-Foundry-090909?style=for-the-badge&logo=solidity)
![Vyper](https://img.shields.io/badge/-Vyper-purple?style=for-the-badge&logo=python&logoColor=white)
![Echidna](https://img.shields.io/badge/-Echidna-090909?style=for-the-badge&logo=ethereum)
![Halmos](https://img.shields.io/badge/-Echidna-090909?style=for-the-badge&logo=ethereum)
![Bun](https://bun.sh/)

Vyper `0.4.0` is used in the project.

! Given project was migrated from hardhat to foundry.
https://github.com/NomicFoundation/hardhat/issues/5479

---

## Table of Contents
- [Presale Smart Contract Vyper Edition](#presale-smart-contract-vyper-edition)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
    - [Public or Whitelisted Presales](#public-or-whitelisted-presales)
    - [Customizable Cliff and Unlock Periods](#customizable-cliff-and-unlock-periods)
    - [Configurable Token Prices and Timeframes](#configurable-token-prices-and-timeframes)
    - [All-in-One Solution](#all-in-one-solution)
  - [Requirements](#requirements)
    - [Poetry](#poetry)
  - [Get Started](#get-started)
  - [Misc](#misc)
  - [Testing Approach](#testing-approach)

---

## Overview

This project introduces a fully decentralized presale smart contract built in Vyper, designed to streamline the process of Initial DEX Offerings (IDO) and token vesting—all within a single, robust contract. The goal is to provide an efficient and versatile solution for token distribution while maintaining full decentralization.
Key Features

### Public or Whitelisted Presales
- Support for open-to-all or invite-only sales through whitelisted addresses.
- Flexible configuration options for inclusivity or exclusivity as needed.

### Customizable Cliff and Unlock Periods
- Token vesting with tailor-made cliff periods for gradual token releases.
- Decentralized control over unlock schedules to ensure trust and transparency.

### Configurable Token Prices and Timeframes
- Set custom token pricing for the presale to meet project-specific requirements.
- Define exact time windows for presales to align with marketing or strategic goals.

### All-in-One Solution
- Combines IDO and vesting functionality, reducing the need for multiple contracts.
- Simplified deployment and management for token projects of any scale.

## Requirements

- [Foundry](https://book.getfoundry.sh/)
- [poetry](https://github.com/python-poetry/poetry)
- [python3](https://www.python.org/downloads/)
- [just](https://github.com/casey/just)
- [bulloak](https://github.com/alexfertel/bulloak)
- [echidna](https://github.com/crytic/echidna)
- [halmos](https://github.com/a16z/halmos)

### Poetry 

Poetry is used here for installing vyper compiler with selected version in python virtual environment. Such as it is recommend in official documentation. Also Poetry is used as package manager for managing packages like snekmate.

https://docs.vyperlang.org/en/stable/installing-vyper.html

## Get Started

```shell
just setup
```

```shell
just build
```

```shell
just compile
```

## Misc

Format your Solidity code
```shell
forge fmt --check
```

## Testing Approach

Using the Branching Tree Technique with Bulloak in Foundry Testing

In my recent Foundry project, I adopted the Branching Tree Testing Technique using Bulloak to ensure comprehensive coverage and robust testing of smart contracts. This approach, inspired by the natural growth patterns of a tree, emphasizes systematically exploring all possible paths of execution within the contract, branching out to test edge cases and unexpected scenarios.
What is the Branching Tree Technique?

The Branching Tree Technique organizes tests hierarchically, much like a tree structure:

    - Root: Represents the base or initial state of the contract.
    - Branches: Correspond to different paths or scenarios derived from contract functions.
    - Leaves: Represent specific edge cases or end states.

This technique ensures no part of the logic remains untested, particularly in complex scenarios with multiple dependencies or conditional flows.