// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "script/DeployFundMe.s.sol";

// Sepolia ETH / USD Address
// https://docs.chain.link/data-feeds/price-feeds/addresses
// 0x694AA1769357215DE4FAC081bf1f309aDC325306

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
        console.log("testMinimumDollarIsFive \u2714");
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.i_owner(), msg.sender); // address(this) is the fundmetest contract address
        console.log("testOwnerIsMsgSender \u2714"); // msg.sender is us
    }

    function testPriceFeedVersion() public view {
        assertEq(fundMe.getVersion(), 4);
    }
}
