// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IFlashLoanReceiver.sol";
import "./FlashLoanTestToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title FlashLoanSimulator
/// @notice Simulates Aave-style flash loans without real liquidity
contract FlashLoanSimulator is Ownable {
    FlashLoanTestToken public immutable token;

    constructor(address _token) Ownable(msg.sender) {
        token = FlashLoanTestToken(_token);
    }

    /// @notice Simulate a flash loan
    /// @param receiver The contract that implements IFlashLoanReceiver
    /// @param amount The loan amount
    function flashLoan(address receiver, uint256 amount) external onlyOwner {
        uint256 balanceBefore = token.balanceOf(address(this));

        // Mint tokens to simulate liquidity
        //token.mint(receiver, amount);

        // Call borrower logic
        IFlashLoanReceiver(receiver).executeOperation(amount);

        // Pull repayment (+1 fee) back to simulator
        uint256 repaymentAmount = amount + 1;
        bool success = token.transferFrom(receiver, address(this), repaymentAmount);
        require(success, "Repayment transfer failed");

        uint256 balanceAfter = token.balanceOf(address(this));
        require(balanceAfter >= balanceBefore + repaymentAmount, "Loan not repaid properly");
    }
}
