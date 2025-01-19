This is part of the Cyfrin Solidity Blockchain Course.

*[⭐️ Cyfrin Updraft | Remix Storage Factory](https://updraft.cyfrin.io/courses/solidity/storage-factory/factory-introduction)*

*[🎥  (3:29:58) | Lesson 3 | Remix Storage Factory](https://www.youtube.com/watch?v=umepbfKp5rI&t=12598s)*

## Getting Started
1. Go to [Remix](https://remix.ethereum.org/).
2. Paste the code from `SimpleStorage.sol`, `StorageFactory.sol`, and `AddFiveStorage.sol` into a new file in Remix.
3. Hit `Compile`.
4. Hit `Deploy` for whatever contract you want.

## Resources talked about in the Video:
1. Bits and Bytes Video link by Linus Tech tips: https://www.youtube.com/watch?v=Dnd28lQHquU.

For a more in depth blog on working with remix, read [here](https://docs.chain.link/docs/deploy-your-first-contract/).

## Lesson Learned
##### Write & Read in EVM
1. Write & Read

These are locations where the EVM (Ethereum Virtual Machine) can both write data and read data back:
- Stack
    - A last-in, first-out (LIFO) data structure used for quick and temporary storage of values during computation.
    - Holds small data like operands and results of computations.
- Memory
    - A temporary, volatile storage for data during the execution of a transaction or contract.
    - It resets after the execution ends.
- Storage
    - A permanent storage associated with a smart contract.
    - Costly to use but retains data between transactions.
- Transient Storage
    - Temporary storage that resets after the transaction ends.
    - Useful for ephemeral data that doesn’t need to persist.
- Calldata
    - Read-only input data sent with a transaction or call to a smart contract.
    - Contains the arguments or parameters passed to functions.
- Code
    - The bytecode of a smart contract that is executed by the EVM.
    - Can be read but not altered during execution.
- Returndata
    - Data returned by a function call or transaction.
    - Used when handling external calls or checking the output of a function.

2. Write

Locations where the EVM can write data but not read it back:
- Logs
    - Logs are events emitted by a smart contract, stored on the blockchain.
    - These are written to the blockchain for external use (e.g., monitoring, off-chain analysis) but are not accessible to the contract itself.

3. Read

Locations where the EVM can only read data:
- Transaction Data (& Blobhash)
    - Includes the data sent with a transaction (e.g., gas, sender address, calldata).
    - Blobhash refers to transaction blobs in data availability-focused implementations.
- Chain Data
    - Refers to blockchain-related metadata like block hashes, timestamps, or block numbers.
- Gas Data
    - Information about gas limits and gas prices available during transaction execution.
- Program Counter
    - Tracks the current instruction being executed in the EVM bytecode.
- (Other)
    - Refers to additional sources of read-only data like precompiled contract data or protocol-specific parameters.

##### Value Types vs Reference Types
1. Value Types

Types like uint256, bool, int, and address store their data directly and do not need a specific data location (e.g., memory, storage, calldata).

2. Reference Types

Types like string, bytes, array, and struct require a data location (memory, storage, calldata) because they store references to their data.

##### Other Notes
- There is no floating point in Solidity. You should keep numbers in whole number format. You can place decimal place in your front-end code. Take a look at how ERC20 contract was designed.
- Contract is like as class in other programming language.
- Keep the solidity version the same in a project!
