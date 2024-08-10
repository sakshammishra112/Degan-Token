// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DeganToken is ERC20, ERC20Burnable, Ownable(msg.sender) {

    uint256 constant MULTIPLIER = 10**2;
    
    // Define the items for sale with their corresponding costs
    struct Item {
        string name;
        uint256 cost;
    }
    
    // List of items available for sale
    Item[] public itemsForSale;
    // User's inventory
    string[] public myInventory;

    constructor() ERC20("Degen", "DGN") {
        // Initialize items for sale
        itemsForSale.push(Item("Yellow Shirt", 200));
        itemsForSale.push(Item("M416 Skin", 400));
        itemsForSale.push(Item("Shotgun Skin", 500));
        itemsForSale.push(Item("Legendary Marine Outfit", 550));
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function mint1(address to, uint256 amount) external onlyOwner {
        _mint(to, amount * MULTIPLIER);
    }

    function burnToken(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function transfer1(address to, uint256 amount) external {
        _transfer(msg.sender, to, amount);
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function getItemsForSale() external view returns (Item[] memory) {
        return itemsForSale;
    }

    function getInventory() external view returns (string[] memory) {
        return myInventory;
    }

    function storeItem(uint256 itemIndex) external returns (string memory) {
        require(itemIndex < itemsForSale.length, "Invalid item index");

        Item memory item = itemsForSale[itemIndex];
        uint256 cost = item.cost;
        
        require(balanceOf(msg.sender) >= cost, "Insufficient balance");

        _burn(msg.sender, cost);
        myInventory.push(item.name);

        return string(abi.encodePacked("You now have a ", item.name));
    }
}
