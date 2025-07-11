// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IFlashLoanReceiver.sol";
import "./FlashLoanTestToken.sol";

/// @title FlashLoanBorrower
/// @notice Receives and repays simulated flash loans
contract FlashLoanBorrower is IFlashLoanReceiver {
    FlashLoanTestToken public immutable token;
    address public immutable simulator;

    constructor(address _token, address _simulator) {
        token = FlashLoanTestToken(_token);
        simulator = _simulator;
    }

    /// @notice Called by the simulator during flashLoan()
    /// @param amount The loaned amount
    function executeOperation(uint256 amount) external override {
        require(msg.sender == simulator, "Unauthorized caller");

        // (In real use: do arbitrage, liquidation, etc.)
        // Here we just approve repayment

        // Approve the simulator to pull the repayment + 1 minimal fee
        uint256 repaymentAmount = amount + 1;
        token.approve(simulator, repaymentAmount);
    }
}
