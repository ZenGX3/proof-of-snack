// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SupplyChain {
    enum Stage { Farm, Processing, Distribution, Retail }

    struct Checkpoint {
        Stage stage;
        string location;
        int256 temperature;   // stored as °C × 10 to avoid floats
        address handler;
        string notes;
        uint256 timestamp;
    }

    mapping(uint256 => Checkpoint[]) public checkpoints;  // tokenId → history
    mapping(uint256 => Stage) public currentStage;

    event CheckpointAdded(uint256 indexed tokenId, Stage stage, address handler);
    event ContaminationAlert(uint256 indexed tokenId, string reason);

    function addCheckpoint(
        uint256 tokenId,
        Stage stage,
        string memory location,
        int256 temperature,
        string memory notes
    ) public {
        require(uint8(stage) >= uint8(currentStage[tokenId]), "Cannot go backwards in chain");

        // Auto-raise alert if temperature exceeds safe threshold
        if (temperature > 80 || temperature < -200) {
            emit ContaminationAlert(tokenId, "Temperature out of safe range");
        }

        checkpoints[tokenId].push(Checkpoint(
            stage, location, temperature, msg.sender, notes, block.timestamp
        ));
        currentStage[tokenId] = stage;
        emit CheckpointAdded(tokenId, stage, msg.sender);
    }

    function getCheckpoints(uint256 tokenId) public view returns (Checkpoint[] memory) {
        return checkpoints[tokenId];
    }
}