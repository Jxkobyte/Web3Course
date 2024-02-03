// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22; // use 0.8.22 or above

// transation hash: https://sepolia.etherscan.io/tx/0xd36b6e77187cf15f660baaa94052d94c953ef64d13051f8f390ea3010b6db7ff

contract SimpleStorage {
    uint8 public favoriteNumber; // == 0
    
    mapping(string => uint256) public nameToFavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public peopleArr;

    function store(uint8 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        peopleArr.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}