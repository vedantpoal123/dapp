// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {
    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function transfer(address payable _to) external payable {
        require(_to != address(0), "Invalid recipient address");
        require(msg.value > 0, "Invalid amount");

        // Transfer Ether to the recipient
        _to.transfer(msg.value);

        // Emit the Transfer event
        emit Transfer(msg.sender, _to, msg.value);
    }

    function withdraw(uint256 _amount) external onlyOwner {
        require(_amount > 0, "Invalid withdrawal amount");
        require(address(this).balance >= _amount, "Insufficient balance");

        // Transfer Ether to the owner
        payable(owner).transfer(_amount);

        // Emit the Transfer event
        emit Transfer(address(this), owner, _amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
