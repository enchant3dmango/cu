// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    // Could we make i_owner constant? 
    // No, we can't, we should make it immutable bcoz we are going to assign the value at deployment time
    // We can only assign value in the constructor for a immutable variable
    // Also, constant must be set at the time of the declaration, like var MINIMUM_USD
    address public /* immutable */ i_owner;
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        // Sepolia ETH / USD address
        // Use [1] if you are deploying to Sepolia Testnet, use [2] if you are deploying yo ZKsync Sepolia Testnet
        // [1] https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum#sepolia-testnet
        // ->  0x694AA1769357215DE4FAC081bf1f309aDC325306
        // [2] https://docs.chain.link/data-feeds/price-feeds/addresses?network=zksync#sepolia-testnet
        // -> 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        return priceFeed.version();
    }

    modifier onlyOwner() {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // There are three different approaches to withdraw balance: transfer, send, and call
        // For now, call is the most recommended approach

        // Transfer approach
        // payable(msg.sender).transfer(address(this).balance);

        // Send approach
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // Call approach
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \
    //         yes  no
    //         /     \
    //    receive()?  fallback()
    //     /   \
    //   yes   no
    //  /        \
    //receive()  fallback()

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}