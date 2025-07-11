// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title FlashLoanTestToken
/// @notice ERC20 token with minting capability for simulation
contract FlashLoanTestToken is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("TestToken", "TTK") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }

    /// @notice Mint new tokens to an address
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
