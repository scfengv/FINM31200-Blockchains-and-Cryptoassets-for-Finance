// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleStorage {
    // State variable to store a number
    uint256 private favoriteNumber;
    
    // Mapping to store people's favorite numbers
    mapping(string => uint256) public nameToFavoriteNumber;
    
    // Array to store all people
    Person[] public people;
    
    // Struct to represent a person
    struct Person {
        string name;
        uint256 favoriteNumber;
    }
    
    // Event emitted when favorite number is updated
    event NumberUpdated(uint256 indexed newNumber, address indexed updater);
    event PersonAdded(string indexed name, uint256 favoriteNumber);
    
    // Store a favorite number
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        emit NumberUpdated(_favoriteNumber, msg.sender);
    }
    
    // Retrieve the favorite number
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }
    
    // Add a person with their favorite number
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(Person(_name, _favoriteNumber));
        nameToFavoriteNumber[_name] = _favoriteNumber;
        emit PersonAdded(_name, _favoriteNumber);
    }
    
    // Get person by index
    function getPerson(uint256 _index) public view returns (string memory, uint256) {
        require(_index < people.length, "Index out of bounds");
        Person memory person = people[_index];
        return (person.name, person.favoriteNumber);
    }
    
    // Get total number of people
    function getPeopleCount() public view returns (uint256) {
        return people.length;
    }
}