//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract PandaCoin is ERC20, Ownable, ERC20Buranable {
    event tokenMinted(address indexed owner, uint256 amount, string message);
    event additionalTokenMinted(
        address indexed owner,
        uint256 amount,
        string message
    );
    event tokenBurned(address indexed owner, uint256 amount, string message);

    // initial coin minting
    constructor() ERC20("PandaCoin", "PAC") {
        _mint(msg.sender, 1000 * 10**decimals());
        emit tokenMinted(
            msg.sender,
            1000 * 10**decimals(),
            "Initial supply of tokens minted"
        );
    }

    // additional coin minting by the user
    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
        emit additionalTokenMinted(
            msg.sender,
            _amount,
            "Additional tokens minted"
        );
    }

    // burn coin by the owner only
    function burn(uint256 _amount) public override onlyOwner {
        _burn(msg.sender, _amount);
        emit tokenBurned(msg.sender, _amount, "Token burned");
    }
}
