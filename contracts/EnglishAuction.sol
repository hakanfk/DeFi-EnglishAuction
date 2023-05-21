// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

interface IERC721 {
    function safeTransferFrom(address from, address to, uint tokenId) external;

    function transferFrom(address, address, uint) external;
}

contract EnglishAuction{

    IERC721 public immutable nft;
    uint public immutable nftId;
    uint public highestBid;
    address payable public immutable seller;

    bool public started;
    bool public ended;
    uint public endAt;
    address public highestBidder;

    mapping(address => uint) public offers;

    constructor(address _nftAddress, uint _nftId, uint _highestBid){
        nft = IERC721(_nftAddress);
        nftId = _nftId;

        seller = payable(msg.sender);
        highestBid = _highestBid;
    }

    /* 
        Functions
     */
    function start(uint _time) external {
        require(!started, "Already in an auction");
        require(seller == msg.sender, "You dont own this NFT");

        nft.safeTransferFrom(msg.sender, address(this), nftId);
        started = true;
        endAt = block.timestamp + _time;
    }

    function bid() external payable{
        require(started, "Auction not started");
        require(msg.value > highestBid, "Raise your offer");
        require(seller != msg.sender, "You already own this NFT");

        if(highestBidder != address(0)){
            highestBidder = msg.sender;
            offers[msg.sender] = msg.value;
            highestBid = msg.value;
        }else{
            highestBidder = msg.sender;
            highestBid = msg.value;
        }

    }

    function withdraw() external{
        require(offers[msg.sender] > 0, "You didn't offer any amount");

        uint balance = offers[msg.sender];
        offers[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }

    function end() external{
        require(started);
        require(!ended);
        require(block.timestamp >= endAt);

        ended = true;

        if(highestBidder != address(0)){
            nft.safeTransferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        }else{
            nft.safeTransferFrom(address(this), seller, nftId);
        }

    }

    /* 
        Modifiers 
    */
}