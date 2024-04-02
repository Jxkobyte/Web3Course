# Foundry Fund Me

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`

## Quickstart

```
git clone https://github.com/Jxkobyte/Web3Course/tree/main/foundry-f23/foundry-fund-me-f23
cd foundry-fund-me-f23
forge build
```

### Optional Gitpod

If you can't or don't want to run and install locally, you can work with this repo in Gitpod. If you do this, you can skip the `clone this repo` part.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://github.com/Jxkobyte/Web3Course/tree/main/foundry-f23/foundry-fund-me-f23)

# Usage

## Deploy:

```
forge script script/DeployFundMe.s.sol
```

# Private Key
```
cast wallet import defaultKey --interactive
```
## Usage
```
--acount defaultKey
forge script script/DeploySimpleStorage.s.sol --rpc-url $SEPOLIA_RPC_URL --account defaultKey --broadcast
```

# Testing

```
forge test
```

or 

```
// Only run test functions matching the specified regex pattern.

"forge test -m testFunctionName" is deprecated. Please use 

forge test --match-test testFunctionName
forge test --mt testFunctionName
```

or

```
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test Coverage

```
forge coverage
```

# Deployment to a testnet or mainnet

1. Setup environment variables

You'll want to set your `SEPOLIA_RPC_URL` and `PRIVATE_KEY` as environment variables or use cast wallet. You can add them to a `.env` file, similar to what you see in `.env.example`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).
- `SEPOLIA_RPC_URL`: This is url of the sepolia testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

Optionally, add your `ETHERSCAN_API_KEY` if you want to verify your contract on [Etherscan](https://etherscan.io/).

1. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some testnet ETH. You should see the ETH show up in your metamask.

3. Deploy

```
forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
```

## Scripts

After deploying to a testnet or local net, you can run the scripts. 

Using cast deployed locally example: 

```
cast send <FUNDME_CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY>
```

or
```
forge script script/Interactions.s.sol --rpc-url sepolia  --private-key $PRIVATE_KEY  --broadcast
```

### Withdraw

```
cast send <FUNDME_CONTRACT_ADDRESS> "withdraw()"  --private-key <PRIVATE_KEY>
```

## Estimate gas

You can estimate how much gas things cost by running:

```
forge snapshot
```

And you'll see an output file called `.gas-snapshot`


# Formatting


To run code formatting:
```
forge fmt
```


# Thank you!

If you appreciated this, feel free to follow me or donate!

Metamask Address: 0x69B82080161e5804AdB3C31A172A12485c5e469e

[![Jacob Fallows Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/jakobi832)
[![Jacob Fallows Linkedin](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jacob-fallows-73b39a143/)


# Notes

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

chisel // write solidity in the shell

forge snapshot --mt testWithdrawWithMultipleFunders
forge test --mt testWithdrawWithMultipleFunders -vv

forge inspect FundMe storageLayout

FundMeTest:testWithdrawWithMultipleFunders() (gas: 496562)
FundMeTest:testWithdrawWithMultipleFundersCheaper() (gas: 495748)

forge install Cyfrin/foundry-devops --no-commit

forge script script/Interactions.s.sol:FundFundMe --rpc-url $RPC_URL --account defaultKey


Makefile
make deploy