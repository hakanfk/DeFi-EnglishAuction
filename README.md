# DeFi-EnglishAuction
This repository contains the Solidity code for an Ethereum-based smart contract implementing the English Auction system for NFT (Non-Fungible Token) trading.

## Contract Description
The English Auction contract facilitates an auction of a single NFT, represented by the ERC721 standard. The auction is initiated by the current owner of the NFT (the seller), and participants can place bids until a set time period expires. The highest bid at the end of this period wins the auction and the NFT.

## Contract Details
The contract's constructor accepts the address of the NFT's smart contract (_nftAddress), the unique identifier of the NFT being auctioned (_nftId), and the initial highest bid (_highestBid).

Key functions include:

start(uint _time): Begins the auction, which lasts for _time seconds. Only the seller can start the auction, and the NFT to be auctioned is transferred to this contract for the duration of the auction.

bid(): Allows a user to place a bid. The bid value must be higher than the current highest bid, and the bidder must not be the seller.

withdraw(): Allows a user to withdraw their offers.

end(): Ends the auction, transferring the NFT to the highest bidder and the highest bid to the seller.

Please note that all amounts are in Wei, and Ether should be converted to Wei before interactions.

## Setup and Deployment
You'll need an Ethereum development environment like Truffle or Hardhat to compile and deploy the contract. Also, you'll need MetaMask or similar to interact with the deployed contract.

## Usage
First, deploy the contract to your chosen Ethereum network. Then, call the functions according to your auction requirements. Ensure that transactions calling bid() attach the correct amount of Ether.

Please ensure you have the appropriate permissions and the correct token ID when initiating the auction.

## Important Note
This contract does not implement any fees or auctioneer cuts. All proceeds from the auction go directly to the seller.

## Safety
This contract follows the ERC721 standard for safe transfers, which ensures that only tokens which implement the ERC721 standard can be auctioned.
