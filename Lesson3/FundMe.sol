// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

// withdraw funds
// receive funds
// set minimum funding value in usd 
contract FundMe {
    using PriceConverter for uint256;
    
    uint256 public minimumUSD = 50 * 1e18;

    address[] public funders;

    mapping(address => uint256) public addressToAmountFunded; 


    function fund() public payable {
        // users send additional funds in wei

        

        // if the require statement is false the transaction will revert along with any changes
        // to state, essentially the transaction never happened
        // any remaining gas is sent back, e.g. stuff after the require statement
        // gas spent before the require statement will be used up
        // require(msg.value > 1e18, "Didn't send enough funds!"); // 1 * e^18 for wei to eth

        require(msg.value.getConversionRate() >= minimumUSD, "Please send at least $50usd worth of eth");

        funders.push(msg.sender);

        addressToAmountFunded[msg.sender] = msg.value; // could be += to account for multiple donations
    }

    // function withdraw(){}

    

}
