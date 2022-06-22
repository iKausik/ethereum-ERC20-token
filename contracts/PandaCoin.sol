//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract PandaCoin is ERC20, Ownable, ERC20Burnable {
    event tokenMinted(address indexed owner, uint256 amount, string message);
    event additionalTokenMinted(
        address indexed owner,
        uint256 amount,
        string message
    );
    event tokenBurned(address indexed owner, uint256 amount, string message);
    event tokenRequested(address indexed user, uint256 amount, string message);

    // initial PAC minting
    constructor() ERC20("PandaCoin", "PAC") {
        _mint(msg.sender, 1000 * 10**decimals());

        emit tokenMinted(
            msg.sender,
            1000 * 10**decimals(),
            "Initial supply of tokens minted"
        );
    }

    // mint additional PAC by the owner
    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);

        emit additionalTokenMinted(
            msg.sender,
            _amount,
            "Additional tokens minted"
        );
    }

    // burn PAC by the owner
    function burn(uint256 _amount) public override onlyOwner {
        _burn(msg.sender, _amount);

        emit tokenBurned(msg.sender, _amount, "Token burned");
    }

    // request PAC by anyone
    function requestToken(address _to, uint256 _amount) public {
        if (totalSupply() < 100) {
            _mint(owner(), 1000 * 10**decimals());
        }

        require(_amount <= 10, "You can request a max of 10 PAC at a time.");
        _transfer(owner(), _to, _amount);

        emit tokenRequested(
            msg.sender,
            _amount,
            "Requested PAC Token sent to the given address"
        );
    }

    // check PAC balance
    function myTokenBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
