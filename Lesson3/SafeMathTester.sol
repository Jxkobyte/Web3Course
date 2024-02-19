// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SafeMathTester {
    uint8 public bigNumber = 255;

    function add() public {
        // unchecked{bigNumber += 1;} do not prevent overflow, can save some gas
        bigNumber += 1;
    }

    // overflow is prevented in version 8 of solidity, transation will fail
}