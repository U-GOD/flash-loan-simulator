# Flash Loan Simulator – Aave-Style Atomic Loan Framework
This project demonstrates a minimal simulation of Aave-style flash loans using Solidity smart contracts. It allows developers to understand how flash loans work without requiring real liquidity pools.

## 🚀 Overview
Flash loans enable borrowing of assets with **no upfront collateral**, as long as the borrowed amount (plus a fee) is returned within the same transaction. If repayment fails, the entire transaction reverts.

This project includes:
- A **mintable ERC-20 token** (`FlashLoanTestToken`) to simulate liquidity.
- A **FlashLoanSimulator** contract that issues flash loans and enforces repayment.
- A **FlashLoanBorrower** contract that receives the loan and performs repayment logic.
- An interface (`IFlashLoanReceiver`) that ensures the borrower contract implements the required callback.

## 📂 Contracts

### 1️⃣ FlashLoanTestToken.sol
A simple ERC-20 token inheriting from OpenZeppelin's ERC20, with a public `mint()` function to create tokens for testing purposes.

### 2️⃣ FlashLoanSimulator.sol
The lender contract:
- Issues flash loans to borrowers.
- Calls `executeOperation()` on the borrower.
- Requires repayment with a small fee in the same transaction.

### 3️⃣ IFlashLoanReceiver.sol
An interface defining:
```solidity
This ensures standard interaction between the simulator and borrower contracts.

### 4️⃣ FlashLoanBorrower.sol
Implements the `executeOperation()` callback and approves repayment to the simulator contract.

---

## 🛠️ Deployment and Testing

1. **Deploy `FlashLoanTestToken.sol`**
   - Constructor: `initialSupply = 0` (or any starting amount).

2. **Deploy `FlashLoanSimulator.sol`**
   - Constructor: pass the `FlashLoanTestToken` address.

3. **Deploy `FlashLoanBorrower.sol`**
   - Constructor: pass the `FlashLoanTestToken` and `FlashLoanSimulator` addresses.

4. **Mint tokens to the borrower contract**
   - Call `mint(borrowerAddress, amount)` on the token contract.

5. **Execute a flash loan**
   - Call `flashLoan(borrowerAddress, loanAmount)` on the simulator contract.

✅ If repayment succeeds, the transaction completes.  
❌ If repayment fails, everything reverts.

---

## ✨ Example Deployed Contracts (zkSync Sepolia)

- **FlashLoanTestToken:**  
  `0xD8639a4FdB006e0D7d7A1AbDec583a9649856599`
- **FlashLoanSimulator:**  
  `0xbd4c9697814443851381f50A99768DDE0F9C0597`
- **FlashLoanBorrower:**  
  `0x32B8A12BC01Afd1000C4d024Ca60256f2DB82eAb`

---

## 📖 Learning Outcomes

This project helps you understand:
- How flash loans work at a low level.
- Atomicity (everything happens in one transaction or fails).
- How borrower contracts must implement standardized callbacks.
- How DeFi protocols enforce repayment logic.

---

## 📎 Resources

- [Aave Flash Loans Documentation](https://docs.aave.com/developers/guides/flash-loans)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts)

---

## 📎 Resources

- [Aave Flash Loans Documentation](https://docs.aave.com/developers/guides/flash-loans)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts)
