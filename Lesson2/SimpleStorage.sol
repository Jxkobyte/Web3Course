// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22; // use 0.8.22 or above
// pragma solidity 0.8.7; // use exactly this version
// pragma solidity >=0.8.7 <0.9.0; // use 0.8.7 up to 0.9.0 but not including 0.9.0

// boolean, uint, int, address, bytes
// bool hasFavoriteNumber = true;
// string favoriteNumberInText = "Seven";
// int256 favoriteInt = -3333;
// address myAddress = 0x249Af67Eb92C5A31241df81E16Cb3C400c5E2157;
// bytes4 favoriteBytes = "cats"; // 0xnf9e8sl3, bytes4 can fit 4 chars, bytes32 is the max

contract SimpleStorage {
    // public variables have an automatic or implicit getter function assigned
    uint8 public favoriteNumber; // == 0

    uint8 someNumber = 5; // default visibility is internal

    
    mapping(string => uint256) public nameToFavoriteNumber;


    // People public person = People({favoriteNumber: 7, name: "Jacob"});

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // dynamic array
    People[] public peopleArr;

    // static array: People[5]

    //                   use underscore for function parameters
    function store(uint8 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    
    // view and pure don't cost any gas
    // when declaring a function as view or pure it will not let you update the state of the blockchain
    // view can only read state, pure cannot read state

    function retrieve() public view returns(uint8) {
        return favoriteNumber;
    }

    // pure is used for helper functions
    function power(uint256 num, uint256 pow) public pure returns (uint256) {
        return num ** pow;
    }


    // calldata: used for temporary variable that is unchanged
    // memory: temporary, ends when scope ends, can be modified
    // storage: default for global variables, permanent variable

    // must specifiy data locations for array, struct or mapping, uint256 is automatically assigned memory
    // string is an array of bytes
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        peopleArr.push(newPerson);

        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}
