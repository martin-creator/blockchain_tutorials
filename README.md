
# Stablecoin Project

## Introduction

Welcome to the **Stablecoin Project**! This project aims to create a decentralized stablecoin pegged to the US Dollar (USD). Our goal is to design a robust, algorithmically stabilized token that leverages exogenous cryptocurrency collateral to maintain its peg while ensuring transparency and decentralization.

This README serves as the central documentation for the project's design and development notes. As the project evolves, we'll expand this document to include setup instructions, usage guides, and more.

## Project Overview

Our stablecoin is designed with the following core principles:

- **Relative Stability**: The stablecoin will be anchored to the US Dollar.
- **Stability Mechanism**: The minting and burning processes will be algorithmically decentralized.
- **Collateral**: The stablecoin will be backed by exogenous cryptocurrency assets (wETH and wBTC).

We aim to achieve stability by integrating Chainlink Pricefeeds to accurately determine the USD value of deposited collateral. This ensures that the value of minted tokens is always backed by sufficient collateral in USD terms.

## Design Details

### 1. Relative Stability: Pegged to the US Dollar

The stablecoin will maintain a 1:1 peg with the US Dollar. To achieve this, we will:

#### 1.1 Chainlink Pricefeeds
- Leverage Chainlink Pricefeeds to fetch real-time, decentralized price data for collateral assets (wETH and wBTC) in USD.
- This ensures accurate valuation of collateral when users mint or burn stablecoins.

#### 1.2 Function to Convert ETH & BTC to USD
- Implement a function in our smart contracts to convert deposited wETH and wBTC into their USD equivalent using Chainlink Pricefeeds.
- This conversion will be used to calculate the amount of stablecoin that can be minted based on the collateral provided.

### 2. Stability Mechanism: Algorithmic and Decentralized

The minting and burning of the stablecoin will be governed by algorithmic rules enforced through smart contracts, ensuring a decentralized and transparent process.

#### 2.1 Collateralized Minting
- Users can only mint the stablecoin if they provide sufficient collateral (in wETH or wBTC).
- The amount of stablecoin minted will be proportional to the USD value of the collateral, maintaining over-collateralization to account for volatility.

#### 2.2 Burning Mechanism
- Users can burn stablecoins to redeem their underlying collateral.
- The burning process will also rely on Chainlink Pricefeeds to ensure the correct amount of collateral is returned based on the current USD value.

### 3. Collateral: Exogenous (Crypto)

The stablecoin will be backed by exogenous cryptocurrency assets, specifically:

#### 3.1 wETH (Wrapped Ethereum)
- Users can deposit wETH as collateral to mint the stablecoin.
- wETH ensures compatibility with Ethereum-based DeFi protocols and provides a standardized token for ETH.

#### 3.2 wBTC (Wrapped Bitcoin)
- Users can deposit wBTC as collateral to mint the stablecoin.
- wBTC brings Bitcoin’s value into the Ethereum ecosystem, allowing us to use it as a stable collateral asset.

## How It Works

1. **Minting**: A user deposits wETH or wBTC into the smart contract. The contract uses Chainlink Pricefeeds to calculate the USD value of the collateral. Based on this value and the required collateralization ratio, the contract mints the appropriate amount of stablecoin and transfers it to the user.
2. **Burning**: A user sends stablecoins back to the contract to burn them. The contract calculates the USD value of the burned tokens using Chainlink Pricefeeds and releases the corresponding amount of wETH or wBTC to the user.
3. **Stability Maintenance**: The system enforces over-collateralization and uses algorithmic rules to prevent under-collateralization. If collateral values drop significantly, liquidation mechanisms may be triggered to maintain the peg.

## Future Development

This section outlines the initial design of the stablecoin. As we progress, we plan to:

- Define specific collateralization ratios and liquidation thresholds.
- Implement additional safety mechanisms (e.g., emergency pauses, governance).
- Add support for more collateral types if needed.
- Conduct extensive testing (unit, integration, fork, and fuzz testing) to ensure robustness.

## Installation

*(To be added as the project develops)*  
Details on how to set up the development environment, install dependencies, and deploy the smart contracts.

## Usage

*(To be added as the project develops)*  
Instructions on how to interact with the stablecoin (minting, burning, checking collateral).

## Testing

*(To be added as the project develops)*  
Details on the testing strategy, including fork testing to verify the state of the system and ensure crucial properties (like the peg) remain unaltered.

## Contributing

*(To be added as the project develops)*  
Guidelines for contributing to the project, including coding standards and pull request processes.

## License

*(To be determined)*  
The project’s licensing information will be specified here.


**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
