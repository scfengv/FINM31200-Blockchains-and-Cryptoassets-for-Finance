// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract MyBank{
    // owner
    // bank balance
    // permissions
    // customers

    // Global Variables
    // msg -> data from whoever sent transaction
    // txn ->
    // block -> miner info, reward, difficulty etc.

    // imports

    // pure / views etc.

    function add_numbers(int a, int b) public pure returns (int){
        return a + b;
    }

    function view_owner() public view returns(address){
        return owner_address;
    }

    function sent_eth(address recipient) public payable{
        payable(recipient).transfer(msg.value);
    }

    string public owner;
    uint256 public bankBalance;
    address public owner_address;
    mapping( address => uint256 ) public customerBalance;

    constructor(string memory owner_, uint256 bankBalance_){
        owner = owner_;
        bankBalance = bankBalance_;
        owner_address = msg.sender;
        customerBalance[msg.sender] = 100;
    }

    // Visibility Specifier
    // public: anyone can see it / use it
    // private: just in this contract
    // internal: this.function() but only in this contract
    // external: contract.function()

    function deposit(uint256 amount) public {
        bankBalance += amount;
    }

    modifier onlyOwner(){
        require(msg.sender == owner_address);
        _;
    }

    function withdraw(uint256 amount) public onlyOwner{
        require(msg.sender == owner_address);
        if (bankBalance >= amount){
            bankBalance -= amount;
            customerBalance[owner_address] += amount;
        }
    }



}