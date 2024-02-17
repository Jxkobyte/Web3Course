// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
* Network: Sepolia
* Aggregator: ETH/USD
* Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
*/

library PriceConverter {

    // https://docs.chain.link/data-feeds/getting-started
    // 0: int256: 263752264930
    function getEthUsdPrice() internal view returns (uint256) {

        AggregatorV3Interface dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        (,int256 price,,,) = dataFeed.latestRoundData();
        return uint256(price * 1e10);
    }


    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getEthUsdPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}