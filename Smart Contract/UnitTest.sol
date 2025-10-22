// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../contracts/SimpleStorage.sol";

contract SimpleStorageTest is Test {
    SimpleStorage public simpleStorage;
    
    function setUp() public {
        simpleStorage = new SimpleStorage();
    }
    
    function testInitialValueIsZero() public {
        uint256 value = simpleStorage.retrieve();
        assertEq(value, 0, "Initial value should be 0");
    }
    
    function testStore() public {
        uint256 expectedValue = 42;
        simpleStorage.store(expectedValue);
        uint256 storedValue = simpleStorage.retrieve();
        assertEq(storedValue, expectedValue, "Stored value should equal expected value");
    }
    
    function testStoreEmitsEvent() public {
        uint256 numberToStore = 123;
        
        vm.expectEmit(true, true, false, true);
        emit SimpleStorage.NumberUpdated(numberToStore, address(this));
        
        simpleStorage.store(numberToStore);
    }
    
    function testAddPerson() public {
        string memory name = "Alice";
        uint256 favoriteNumber = 7;
        
        simpleStorage.addPerson(name, favoriteNumber);
        
        uint256 storedNumber = simpleStorage.nameToFavoriteNumber(name);
        assertEq(storedNumber, favoriteNumber, "Favorite number should match");
        
        uint256 peopleCount = simpleStorage.getPeopleCount();
        assertEq(peopleCount, 1, "People count should be 1");
    }
    
    function testGetPerson() public {
        string memory name = "Bob";
        uint256 favoriteNumber = 99;
        
        simpleStorage.addPerson(name, favoriteNumber);
        
        (string memory retrievedName, uint256 retrievedNumber) = simpleStorage.getPerson(0);
        assertEq(retrievedName, name, "Name should match");
        assertEq(retrievedNumber, favoriteNumber, "Number should match");
    }
    
    function testGetPersonOutOfBounds() public {
        vm.expectRevert("Index out of bounds");
        simpleStorage.getPerson(0);
    }
    
    function testMultiplePeople() public {
        simpleStorage.addPerson("Alice", 7);
        simpleStorage.addPerson("Bob", 99);
        simpleStorage.addPerson("Charlie", 42);
        
        assertEq(simpleStorage.getPeopleCount(), 3, "Should have 3 people");
        assertEq(simpleStorage.nameToFavoriteNumber("Alice"), 7);
        assertEq(simpleStorage.nameToFavoriteNumber("Bob"), 99);
        assertEq(simpleStorage.nameToFavoriteNumber("Charlie"), 42);
    }
    
    function testFuzz_Store(uint256 value) public {
        simpleStorage.store(value);
        assertEq(simpleStorage.retrieve(), value, "Fuzzed value should match");
    }
}