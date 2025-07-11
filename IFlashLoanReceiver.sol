// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Interface that borrower contracts must implement
interface IFlashLoanReceiver {
    /// @notice Called after receiving the flash loan
    /// @param amount The amount of tokens loaned
    function executeOperation(uint256 amount) external;
}
