# About

1. Create minimal Account Abstraction on Ethereum
2. Create minimal Account Abstraction on ZKsync
3. Deploy and send a userOp/transaction through them
    1. Not going to send an AA to Ethereum
    2. But we will send an AA tx to zksync


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
