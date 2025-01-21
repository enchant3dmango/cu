// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 

// Why is this a library and not abstract?
// 1. Libraries can’t hold state or inherit other contracts,
// making them efficient and safe to use for pure or view-only logic like getPrice() and getConversionRate()
// 2. The functions are stateless, meaning they only operate on the input parameters and don’t modify contract state

// Why not an interface?
// 1. An interface cannot contain function implementations like we did in getPrice() and getConversionRate()
// 2. An interface defines external behavior and must be implemented by contracts,
// this code isn’t just defining behavior; it’s implementing the logic for price conversion
// 3. Using a library ensures modular code reuse across contracts
library PriceConverter {
    // We could make this public, but then we'd have to deploy it
    function getPrice() internal view returns (uint256) {
        // Sepolia ETH / USD address
        // Use [1] if you are deploying to Sepolia Testnet, use [2] if you are deploying yo ZKsync Sepolia Testnet
        // [1] https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum#sepolia-testnet
        // ->  0x694AA1769357215DE4FAC081bf1f309aDC325306
        // [2] https://docs.chain.link/data-feeds/price-feeds/addresses?network=zksync#sepolia-testnet
        // -> 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH / USD rate in 18-digit
        return uint256(answer * 10000000000);
    }

    function getConversionRate(
        uint256 ethAmount
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // The actual ETH / USD conversion rate, after adjusting the extra 0s
        return ethAmountInUsd;
    }
}