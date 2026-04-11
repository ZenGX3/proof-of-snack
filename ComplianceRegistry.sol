// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ComplianceRegistry {
    struct Certificate {
        string name;
        string authority;
        string standard;
        uint256 tokenId;
        uint256 validFrom;
        uint256 validUntil;
        address issuedBy;
        bool revoked;
    }

    Certificate[] public certificates;
    mapping(uint256 => uint256[]) public productCerts;  // tokenId → cert indices

    event CertificateAdded(uint256 indexed certId, uint256 tokenId, string standard);
    event CertificateRevoked(uint256 indexed certId, string reason);

    function addCertificate(
        string memory name,
        string memory authority,
        string memory standard,
        uint256 tokenId,
        uint256 validFrom,
        uint256 validUntil
    ) public returns (uint256) {
        uint256 certId = certificates.length;
        certificates.push(Certificate(
            name, authority, standard, tokenId,
            validFrom, validUntil, msg.sender, false
        ));
        productCerts[tokenId].push(certId);
        emit CertificateAdded(certId, tokenId, standard);
        return certId;
    }

    function revokeCertificate(uint256 certId, string memory reason) public {
        certificates[certId].revoked = true;
        emit CertificateRevoked(certId, reason);
    }

    function isCompliant(uint256 tokenId) public view returns (bool) {
        uint256[] memory ids = productCerts[tokenId];
        for (uint i = 0; i < ids.length; i++) {
            Certificate memory c = certificates[ids[i]];
            if (!c.revoked && block.timestamp >= c.validFrom && block.timestamp <= c.validUntil)
                return true;
        }
        return false;
    }
}