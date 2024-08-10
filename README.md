# Degan Token (DT) ERC20 Token Deployment Using Avalanche

This Solidity Smart Contract, DeganToken, is a blockchain-based application designed to provide a secure and transparent way for users to manage their ERC20 tokens, mint new tokens, burn tokens, transfer tokens, and interact with an in-game inventory system. This README provides an overview of the contract's functionalities and instructions for setting up and using the contract.

## Description

The `MyToken` Solidity Smart Contract serves as the backbone of a decentralized application (dApp) that allows users to interact with Ethereum blockchain features. It includes the following key functionalities:The DeganToken Solidity Smart Contract serves as the backbone of a decentralized application (dApp) that allows users to interact with blockchain features on the Avalanche network. It includes the following key functionalities:

* **Mint Tokens:** The contract owner can mint new tokens.
* **Burn Tokens:** Users can burn their tokens, reducing the total supply.
* **Transfer Tokens:** Users can transfer tokens to other Ethereum addresses.
* **In-Game Store:** Users can burn tokens to purchase in-game items which are stored in their inventory.
* **In-Game Balance:** Users can also check their in game balance.
* The contract utilizes Solidity's features such as events, error handling with require and revert statements, and access control through owner verification. These features ensure the contract's reliability, security, and user-friendliness.

## Getting 

### Prerequisites

To use this smart contract, you need to have the following:

* A web browser with MetaMask installed
* Access to Remix IDE (https://remix.ethereum.org/)
* Access to a metamask wallet with their network on Avalanche fuji test network.

### Running the Contract on Remix IDE

1. **Open Remix IDE:**
   Go to [Remix IDE](https://remix.ethereum.org/).

2. **Create a New File:**
   Create a new file in Remix IDE and name it `MyToken.sol`.

3. **Copy the Contract Code:**
   Copy and paste the following Solidity code into the `MyToken.sol` file:
```
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

 ```

## Compile the Contract

1. Go to the "Solidity Compiler" tab on the left panel.
2. Select the compiler version `0.8.20`.
3. Click on the "Compile MyToken.sol" button.


## Deploy the Contract

1. Go to the "Deploy & Run Transactions" tab on the left panel.
2. Select "Injected Web3" as the environment to connect to MetaMask.
3. Make sure you are connected to the Avalanche Fuji Test network.
4. Click on the "Deploy" button next to `MyToken`.

## Interact with the Contract

1. After deploying, you will see the deployed contract under "Deployed Contracts".
2. You can interact with the contract using the available functions (e.g., mint1, burn, transfer1, storeItem, getBalance, getItemsForSale, getInventory).
3. You will be able to see the transation on the deployed contract on snowtrace test weibsite
## Help

If you encounter any issues or have questions about using the smart contract, please contact [sakshammishra112@gmail.com].

## Authors

- Saksham Mishra
  - [sakshammishra112@gmail.com]

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details.
