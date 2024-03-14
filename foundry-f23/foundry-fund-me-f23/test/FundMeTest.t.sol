// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    function setUp() external {
        fundMe = new FundMe();
    }


    function testMinimumDollarIsFive() public view {
        
        assertEq(fundMe.MINIMUM_USD(), 5e18);
        console.log("testMinimumDollarIsFive \u2714");
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.i_owner(), address(this)); // address(this) is the fundmetest contract address
        console.log("testOwnerIsMsgSender \u2714"); // msg.sender is us
    }

    function testPriceFeedVersion() public view {
        assertEq(fundMe.getVersion(), 4);
    }
}