# 🔐 SecureVault Smart Contract

SecureVault is a Solidity smart contract designed for secure Ether management by an administrator. It allows controlled deposits, withdrawals, and transfers, with enhanced logging, balance viewing, and transaction limit enforcement.

---

## 🧠 Overview

This contract provides a simple but robust system for:
- Receiving and storing Ether
- Allowing only the admin to withdraw or forward funds
- Logging every operation
- Protecting against high-risk transfers via a max transaction limit

---

## 🚀 Features

| Feature                         | Description                                                                 |
|---------------------------------|-----------------------------------------------------------------------------|
| Public Ether Deposits           | Anyone can send Ether via `sendEther()` or directly.                       |
| Admin Withdrawals               | Admin can withdraw Ether using `withdrawEther()`.                          |
| Admin Transfers                 | Admin can forward Ether to any address with `sendToAddress()`.            |
| Transaction Limit               | Enforces a max limit per transaction to enhance safety.                    |
| View Vault Balance              | Public function to read current Ether held in contract.                   |
| Events & Logging                | Emits logs for deposits, withdrawals, transfers, and limit changes.        |
| receive() and fallback()        | Accepts plain transfers and unknown function calls.                        |

---

## 📜 Key Functions

### 🔐 Admin-Only Functions

| Function                        | Description                                         |
|---------------------------------|-----------------------------------------------------|
| `withdrawEther(uint256 amount)` | Withdraw Ether from the vault to admin’s address.   |
| `sendToAddress(amount, address)`| Send Ether to any external address.                 |
| `updateTxLimit(uint256)`        | Modify maximum allowed transaction size.            |

### 🌍 Public Functions

| Function             | Description                                              |
|----------------------|----------------------------------------------------------|
| `sendEther()`        | Deposit Ether into the contract (emits event).           |
| `getVaultBalance()`  | View current balance held in the contract.               |

---

## 🔧 Prerequisites

- Solidity version: `^0.8.24`
- IDE: Remix IDE, Hardhat, or Foundry

---

## 🛠️ Deployment Steps (Remix)

1. Open [Remix IDE](https://remix.ethereum.org)
2. Create file: `SecureVault.sol`
3. Compile with version `0.8.24`
4. Deploy contract and make note of the deployed address
5. Test functions:
   - `sendEther()` → deposit ETH
   - `withdrawEther(amount)` → admin withdraws
   - `sendToAddress(amount, address)` → send ETH to another address
   - `updateTxLimit(newLimit)` → update max transaction amount
   - `getVaultBalance()` → view current ETH in contract

---

## 🧪 Example Flow

1. Alice deploys `SecureVault` → becomes admin
2. Bob sends 1 ETH via `sendEther()` or `transfer`
3. Alice withdraws 0.5 ETH using `withdrawEther(0.5 ether)`
4. Alice sends 0.2 ETH to Carol with `sendToAddress(0.2 ether, Carol)`
5. Alice adjusts max limit via `updateTxLimit(5 ether)`

---

## 🧾 License

This project is licensed under [LGPL-3.0-only](https://opensource.org/licenses/LGPL-3.0).


