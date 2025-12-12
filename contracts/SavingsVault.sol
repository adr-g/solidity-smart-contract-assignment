// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SavingsVault {
    //variables
    address public owner;

    //events
    event FundsDeposited(address indexed from, uint256 amount);
    event FundsWithdrawn(address indexed to, uint256 amount);

    //constructor
    constructor(){
        owner = msg.sender;
    }

    //functions
    //deposit ETH in vault
    function deposit() external payable{
        require(msg.value > 0, "Cannot deposit zero ETH");
        emit FundsDeposited(msg.sender, msg.value);
    }

    //withdraw savings
    function withdrawAll() external {
        require(msg.sender == owner, "Only owner can withdraw");
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available");

        (bool sent, ) = owner.call{value: balance}("");
        require(sent, "Transfer failed");

        emit FundsWithdrawn(owner, balance);
    }

    //check vault
    function getVaultBalance() external view returns (uint256) {
        return address(this).balance;
    }
 
 }