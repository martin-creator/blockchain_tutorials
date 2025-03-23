# Rebase Token Protocol with Foundry

This project implements a rebase token protocol using [Foundry](https://book.getfoundry.sh/), a blazing fast and modular toolkit for Ethereum application development written in Rust. Below, you'll find an overview of the rebase token design, followed by instructions for setting up and working with this project using Foundry.

## Rebase Token Concept

Our rebase token protocol is designed to reward users for depositing assets into a vault, with a dynamic interest mechanism that incentivizes early adopters. Here are the three key points of the design:

1. **Deposit and Receive Rebase Tokens**:  
   Users deposit assets into a vault smart contract. In return, the vault calls the rebase token contract, which mints rebase tokens for the user. The amount of rebase tokens minted equals the amount deposited, representing the user's underlying balance in the vault.

2. **Dynamic Balance Updates**:  
   The rebase token's `balanceOf` function is dynamic. It adjusts the user's token balance over time to reflect accrued interest, based on their individual interest rate. This means the number of tokens a user holds grows automatically as interest accumulates.

3. **Interest Rate Mechanism**:  
   The protocol assigns an interest rate to each user based on a global interest rate at the time of their deposit. To incentivize early adopters, the global interest rate can only decrease over time. For example:
   - If the global interest rate is 0.05% per day when a user deposits, they receive a fixed interest rate of 0.05% per day on their balance.
   - If the global interest rate later drops to 0.04% per day, a new user depositing at that time gets 0.04% per day, but the first user's rate remains at 0.05%.

### Example Scenario
- **Day 1**: The global interest rate is 0.05% per day. User A deposits 1000 tokens into the vault. They receive 1000 rebase tokens, and their interest rate is set to 0.05% per day.
- **Day 2**: The global interest rate drops to 0.04% per day. User B deposits 1000 tokens and receives 1000 rebase tokens with an interest rate of 0.04% per day. User A’s interest rate remains at 0.05%.
- Over time, the `balanceOf` function for each user reflects their growing balance based on their respective interest rates.

This mechanism ensures early adopters are rewarded with higher returns while allowing the protocol to adjust rates for sustainability over time.

---

## Foundry

**Foundry is a blazing fast, portable, and modular toolkit for Ethereum application development written in Rust.**  
It’s the perfect tool for building, testing, and deploying our rebase token protocol.

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat, and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions, and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache or Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose Solidity REPL.

### Documentation

For more details on Foundry, check out the official documentation:  
[Foundry Book](https://book.getfoundry.sh/)

---

## Getting Started

### Prerequisites
1. Install Rust: Follow the instructions [here](https://www.rust-lang.org/tools/install).
2. Install Foundry by following the instructions in the [Foundry Book](https://book.getfoundry.sh/getting-started/installation.html).

### Setup
Clone this repository and initialize your Foundry project:

```shell
git clone <your-repo-url>
cd <your-repo-name>
forge init
```

### Project Structure
The smart contracts for the rebase token and vault are located in the `src/` directory. Tests are in the `test/` directory.

---

## Usage

### Build
Compile the smart contracts:

```shell
$ forge build
```

### Test
Run the test suite, including unit tests, integration tests, and invariant tests to ensure the rebase token behaves as expected:

```shell
$ forge test
```

### Format
Format your Solidity code for consistency:

```shell
$ forge fmt
```

### Gas Snapshots
Generate gas usage reports for your contracts:

```shell
$ forge snapshot
```

### Run a Local Node
Use Anvil to run a local Ethereum node for testing:

```shell
$ anvil
```

### Deploy
Deploy the contracts to a network (replace `<your_rpc_url>` and `<your_private_key>` with your own values):

```shell
$ forge script script/Deploy.s.sol:DeployScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Interact with Contracts
Use Cast to interact with deployed contracts, check balances, or send transactions:

```shell
$ cast <subcommand>
```

### Help
Get help for any Foundry tool:

```shell
$ forge --help
$ anvil --help
$ cast --help
```

---

## Contributing

Contributions are welcome! Please check out the [Contributing Guide](https://book.getfoundry.sh/contributing.html) in the Foundry Book for more details on how to contribute to this project or Foundry itself.

---

## Additional Resources

- Check out [Awesome Foundry](https://github.com/foundry-rs/awesome-foundry) for a curated list of resources, guides, tools, and libraries.
- Join the Foundry community on [GitHub](https://github.com/foundry-rs/foundry) to stay updated and get support.
