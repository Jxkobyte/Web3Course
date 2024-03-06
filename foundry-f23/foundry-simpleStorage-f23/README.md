forge script script/DeploySimpleStorage.s.sol --rpc-url [http://localhost:8545](http://localhost:8545/) --account defaultKey --sender 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266 --broadcast

cast --to-base 0x7170b dec

cast wallet import defaultKey --interactive

cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "store(uint256)" 123 --rpc-url [http://localhost:8545](http://localhost:8545/) --account defaultKey

cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "retrieve()”

source .env # load env variables into shell

forge script script/DeploySimpleStorage.s.sol --rpc-url $SEPOLIA_RPC_URL --account sepoliaKey --broadcast

forge fmt - formats files










## Foundry

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
