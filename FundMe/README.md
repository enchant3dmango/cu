This is part of the Cyfrin Foundry Blockchain Developer Course.

*[⭐️ Cyfrin Updraft | Remix Fund Me](https://updraft.cyfrin.io/courses/solidity/fund-me/fund-me-intro)*

## Getting Started

1. Go to [Remix](https://remix.ethereum.org/).
2. Paste the code from `FundMe.sol` and `PriceConverter.sol` into new files in Remix.
3. Hit `Compile`.
4. Hit `Deploy`.

For a more in depth blog on working with remix, [read here](https://docs.chain.link/docs/deploy-your-first-contract/)

## Getting started (zkSync)

1. Go to [Remix](https://remix.ethereum.org/).
2. Paste the code from `FundMe.sol` and `PriceConverter.sol` into a new file inside a folder named `contracts` in Remix.
3. Head to the zkSync plugin tab.
4. Hit `Compile`.
5. Hit `Deploy`.

## Lesson Learned
##### Interface
1. A Solidity interface is like a blueprint or a contract for other contracts.
2. Only has function declarations (names, inputs, outputs) but no implementation (no code inside the functions).
3. Why use it?
    - To ensure that a contract follows a specific structure.
    - Helps different contracts interact with each other, especially if you don't know the exact implementation of the other contract.
    - To enforce a standard structure across multiple contracts.

##### Constructor
A Solidity constructor is a special function that runs only once when the contract is deployed. It's used to set up the initial state of the contract, like initializing variables or setting ownership.

##### Function Modifiers
In Solidity, function modifiers are reusable code blocks that you can use to add logic before, after, or around a function's execution. They help enforce rules or conditions for specific functions, making the code cleaner and more secure.

Key Features?
- Reusable: Write a modifier once, use it in multiple functions.
- Precondition Check: Ensures a condition is met before running the function.
- Customizable Logic: Can modify how and when a function executes.

###### Example
```solidity
pragma solidity 0.8.24;

contract Example {
    address public owner;

    constructor() {
        owner = msg.sender; // Set deployer as owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner!");
        _; // Placeholder for the function's original code
    }

    function restrictedFunction() public onlyOwner {
        // Only the owner can call this
    }
}
```

How It Works?
- The onlyOwner modifier checks if msg.sender is the owner.
- If the condition is true, the function proceeds (_ is replaced by the original function code).
- If false, it reverts with "Not the owner!".

Common Uses?
- Access control (e.g., onlyOwner).
- Input validation (e.g., validInputAmount to check inputs).
- Rate limiting (e.g., oncePerDay).

##### Immutability & Constant
Notes and examples in `FundMe.sol`.

##### Receive & Fallback
Notes and examples in `FundMe.sol`.

##### Other Notes
1. Fetching the ETH/USD price from a Chainlink price feed.
2. Converting an ETH amount (in Wei) to its USD equivalent.
3. When we should use library or interface.
4. Solidity SafeMath.
5. Creating custom errors.