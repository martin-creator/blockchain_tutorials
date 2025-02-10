# Proveably Random Raffle Contracts

## About

This code is to create a proveably random smart contract lottery.

## What we want it to do?

1. Users should be able to enter the raffle by paying for a ticket. The ticket fees are going to be the prize the winner receives.
2. The lottery should automatically and programmatically draw a winner after a certain period.
3. Chainlink VRF should generate a provably random number.

4. Chainlink Automation should trigger the lottery draw regularly.


Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.



The Checks-Effects-Interactions pattern is a crucial best practice in Solidity development aimed at enhancing the security of smart contracts, especially against reentrancy attacks. This pattern structures the code within a function into three distinct phases:

* Checks: Validate inputs and conditions to ensure the function can execute safely. This includes checking permissions, input validity, and contract state prerequisites.
* Effects: Modify the state of our contract based on the validated inputs. This phase ensures that all internal state changes occur before any external interactions.
* Interactions: Perform external calls to other contracts or accounts. This is the last step to prevent reentrancy attacks, where an external call could potentially call back into the original function before it completes, leading to unexpected behavior. (More about reentrancy attacks on a later date)


Example of the Checks-Effects-Interactions pattern in a Solidity function:


```
function coolFunction() public {
    sendA();
    callB();
    checkX();
    checkY();
    updateM();

}

```

In the function above what happens if `checkX()` fails? The EVM goes through a function from top to bottom. That means it will execute `sendA()` then `callB()` then attempt `checkX()` which will fail, and then all the things need to be reverted. Every single operation costs gas, we pay for everything, and we just performed 2 operations, to revert at the 3rd. From this perspective isn't the following more logical?

```function coolFunction() public {
    // Checks
    checkX();
    checkY();

    // Effects
    updateStateM();

    // Interactions
    sendA();
    callB();

}```

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
