// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ParentChildNFT is ERC721 {
    uint256 private tokenIdCounter;
    mapping(uint256 => uint256) private parentIds;
    mapping(uint256 => uint256[]) private childIds;

    constructor() ERC721("ParentChildNFT", "PCNFT") {
        tokenIdCounter = 0;
        _safeMint(msg.sender, tokenIdCounter);
        tokenIdCounter++;
    }

    function createNFT(uint256 parentId) external {
        require(_exists(parentId), "Invalid parent ID");
        require(!_exists(tokenIdCounter), "Token with ID already exists");

        _safeMint(msg.sender, tokenIdCounter);
        parentIds[tokenIdCounter] = parentId;
        childIds[parentId].push(tokenIdCounter);
        tokenIdCounter++;
    }

    function getParentId(uint256 tokenId) external view returns (uint256) {
        require(_exists(tokenId), "Token ID does not exist");
        return parentIds[tokenId];
    }

    function getChildIds(uint256 tokenId) external view returns (uint256[] memory) {
        require(_exists(tokenId), "Token ID does not exist");
        return childIds[tokenId];
    }
}
