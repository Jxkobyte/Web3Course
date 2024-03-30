// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "script/DeployFundMe.s.sol";

// Sepolia ETH / USD Address
// https://docs.chain.link/data-feeds/price-feeds/addresses
// 0x694AA1769357215DE4FAC081bf1f309aDC325306

contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("User");
    uint256 SEND_VALUE = 0.1 ether;
    uint256 GAS_PRICE = 1;

    function setUp() external {
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, 2.0 ether);
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
        console.log("testMinimumDollarIsFive \u2714");
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.getOwner(), msg.sender); // address(this) is the fundmetest contract address
        console.log("testOwnerIsMsgSender \u2714"); // msg.sender is us
    }

    function testPriceFeedVersion() public view {
        assertEq(fundMe.getVersion(), 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        fundMe.fund(); // send 0 value
    }

    function testFundUpdatesFundedDataStructure() public funded {
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddsFunderToFunderArray() public funded {
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithdrawWithSingleFunder() public funded {
        // arrange: set up test
        uint256 ownerStartingBalance = fundMe.getOwner().balance;
        uint256 fundMeStartingBalance = address(fundMe).balance;

        // act: execute the test
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        // assert: check values
        uint256 ownerEndingBalance = fundMe.getOwner().balance;
        uint256 fundMeEndingBalance = address(fundMe).balance;
        assertEq(fundMeEndingBalance, 0);
        assertEq(
            fundMeStartingBalance + ownerStartingBalance,
            ownerEndingBalance
        );
    }

    function testWithdrawWithMultipleFundersCheaper() public funded {
        // ARRANGE
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1; // address(0) may revert

        for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            // vm.prank, vm.deal: hoax does both
            // fund the contract
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 ownerStartingBalance = fundMe.getOwner().balance;
        uint256 fundMeStartingBalance = address(fundMe).balance;

        // ACT
        vm.txGasPrice(GAS_PRICE);
        uint256 gasStart = gasleft(); // 1000 gas
        vm.startPrank(fundMe.getOwner()); // cost 200 gas
        fundMe.cheaperWithdraw();
        vm.stopPrank();
        uint256 gasEnd = gasleft(); // 800 gas
        uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;
        console.log("gasUsed: ", gasUsed);

        // ASSERT
        assert(address(fundMe).balance == 0);
        assert(
            fundMeStartingBalance + ownerStartingBalance ==
                fundMe.getOwner().balance
        );
    }

    function testWithdrawWithMultipleFunders() public funded {
        // ARRANGE
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1; // address(0) may revert

        for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            // vm.prank, vm.deal: hoax does both
            // fund the contract
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 ownerStartingBalance = fundMe.getOwner().balance;
        uint256 fundMeStartingBalance = address(fundMe).balance;

        // ACT
        vm.txGasPrice(GAS_PRICE);
        uint256 gasStart = gasleft(); // 1000 gas
        vm.startPrank(fundMe.getOwner()); // cost 200 gas
        fundMe.withdraw();
        vm.stopPrank();
        uint256 gasEnd = gasleft(); // 800 gas
        uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;
        console.log("gasUsed: ", gasUsed);

        // ASSERT
        assert(address(fundMe).balance == 0);
        assert(
            fundMeStartingBalance + ownerStartingBalance ==
                fundMe.getOwner().balance
        );
    }

    modifier funded() {
        vm.prank(USER); // next transaction is from USER
        fundMe.fund{value: SEND_VALUE}();
        _;
    }
}
