forge test -vv
forge script script/DeployFundMe.s.sol
forge test --match-test testPriceFeedVersion -vvv
forge test --match-test testPriceFeedVersion -vvvv --fork-url $SEPOLIA_RPC_URL
forge coverage --fork-url $SEPOLIA_RPC_URL ## how much code is tested

source .env
forge test --fork-url $SEPOLIA_RPC_URL

mock test: forge test

Running tests...
| File                      | % Lines       | % Statements  | % Branches    | % Funcs      |
|---------------------------|---------------|---------------|---------------|--------------|
| script/DeployFundMe.s.sol | 0.00% (0/3)   | 0.00% (0/3)   | 100.00% (0/0) | 0.00% (0/1)  |
| src/FundMe.sol            | 16.67% (2/12) | 23.53% (4/17) | 0.00% (0/4)   | 25.00% (1/4) |
| src/PriceConverter.sol    | 0.00% (0/6)   | 0.00% (0/11)  | 100.00% (0/0) | 0.00% (0/2)  |
| Total                     | 9.52% (2/21)  | 12.90% (4/31) | 0.00% (0/4)   | 14.29% (1/7) |



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
