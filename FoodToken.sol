// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ✅ Use fixed OZ version (important for Remix)
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.1/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.1/contracts/access/AccessControl.sol";

contract FoodToken is ERC721, AccessControl {
    
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint256 private _tokenIdCounter;

    struct ProductMetadata {
        string name;
        string category;
        string origin;
        uint256 quantity;
        uint256 harvestDate;
        uint256 expiryDate;
        string notes;
        address registeredBy;
        uint256 timestamp;
    }

    mapping(uint256 => ProductMetadata) public products;

    event ProductRegistered(uint256 indexed tokenId, string name, address registeredBy);

    constructor() ERC721("FoodChainToken", "FCT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function registerProduct(
        address to,
        string memory name,
        string memory category,
        string memory origin,
        uint256 quantity,
        uint256 harvestDate,
        uint256 expiryDate,
        string memory notes
    ) public onlyRole(MINTER_ROLE) returns (uint256) {

        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;

        _safeMint(to, tokenId);

        products[tokenId] = ProductMetadata(
            name,
            category,
            origin,
            quantity,
            harvestDate,
            expiryDate,
            notes,
            msg.sender,
            block.timestamp
        );

        emit ProductRegistered(tokenId, name, msg.sender);

        return tokenId;
    }

    // ✅ REQUIRED for OZ v5 (fixes your earlier error)
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}