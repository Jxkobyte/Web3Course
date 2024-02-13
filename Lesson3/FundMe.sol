// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// withdraw funds
// receive funds
// set minimum funding value in usd 
contract FundMe {
    
    uint256 public minimumUSD = 50;


    AggregatorV3Interface internal dataFeed;
    /**
     * Network: Sepolia
     * Aggregator: ETH/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */

    constructor () {
        dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }
    

    function fund() public payable {
        // users send additional funds in wei

        

        // if the require statement is false the transaction will revert along with any changes
        // to state, essentially the transaction never happened
        // any remaining gas is sent back, e.g. stuff after the require statement
        // gas spent before the require statement will be used up
        // require(msg.value > 1e18, "Didn't send enough funds!"); // 1 * e^18 for wei to eth

        require(msg.value >= minimumUSD, "Please send at least $50usd worth of eth");

    }

    // function withdraw(){}

    // 0: int256: 263752264930
    function getEthUsdPrice() public view returns (int256) {
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

}
