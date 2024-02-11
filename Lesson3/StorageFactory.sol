// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "SimpleStorage.sol";

contract StorageFactory {

    // array of simple storage contracts
    SimpleStorage[] public simpleStorageArray;

    function CreateSimpleStorageContract() public {
        simpleStorageArray.push(new SimpleStorage());
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // address, ABI - application binary interface
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}