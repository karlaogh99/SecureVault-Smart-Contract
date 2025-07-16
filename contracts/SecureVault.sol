// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.24;

/// @title SecureVault - A contract to handle secure Ether storage and transfers
/// @author ...
/// @notice Admin can withdraw or forward Ether; emits logs for all activity.
contract SecureVault {
    address public admin;
    uint256 public maxTxLimit = 10 ether;

    event EtherDeposited(address indexed from, uint256 amount);
    event EtherWithdrawn(address indexed to, uint256 amount);
    event EtherTransferred(address indexed to, uint256 amount);
    event MaxTxLimitUpdated(uint256 newLimit);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Access restricted to admin");
        _;
    }

    modifier limitCheck(uint256 amount) {
        require(amount <= maxTxLimit, "Amount exceeds transaction limit");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    /// @notice Allows anyone to deposit Ether to the contract
    function sendEther() external payable {
        require(msg.value > 0, "Must send some Ether");
        emit EtherDeposited(msg.sender, msg.value);
    }

    /// @notice Admin can withdraw Ether from the contract
    function withdrawEther(uint256 amount) external onlyAdmin limitCheck(amount) {
        require(address(this).balance >= amount, "Insufficient balance");
        payable(admin).transfer(amount);
        emit EtherWithdrawn(admin, amount);
    }

    /// @notice Admin can send Ether to any address
    function sendToAddress(uint256 amount, address payable recipient) external onlyAdmin limitCheck(amount) {
        require(address(this).balance >= amount, "Insufficient balance");
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Transfer failed");
        emit EtherTransferred(recipient, amount);
    }

    /// @notice Update the maximum allowed transaction limit
    function updateTxLimit(uint256 newLimit) external onlyAdmin {
        require(newLimit > 0, "Limit must be positive");
        maxTxLimit = newLimit;
        emit MaxTxLimitUpdated(newLimit);
    }

    /// @notice Returns contract's current Ether balance
    function getVaultBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /// @dev Accepts plain Ether transfers
    receive() external payable {
        emit EtherDeposited(msg.sender, msg.value);
    }

    /// @dev Fallback function for non-existent calls
    fallback() external payable {
        emit EtherDeposited(msg.sender, msg.value);
    }
}
