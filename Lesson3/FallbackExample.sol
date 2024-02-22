// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FallbackExample {

    uint256 public result;

    // triggered when receiving an empty calldata transaction
    receive() external payable {
        result = 1;
    }

    // triggered by unknown calldata
    fallback() external payable {
        result = 2;
    }

    // https://solidity-by-example.org/fallback/
}