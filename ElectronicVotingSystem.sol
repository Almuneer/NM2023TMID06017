// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ElectronicVotingSystem {
    // Structure to represent a candidate
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    // State variables
    address public electionAuthority;
    mapping(address => bool) public voters;
    Candidate[] public candidates;

    // Event to notify when a vote is cast
    event VoteCasted(address indexed voter, uint256 candidateIndex);

    // Constructor to set the election authority and candidates
    constructor(string[] memory candidateNames) {
        electionAuthority = msg.sender;

        for (uint256 i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }

    // Function for voters to cast their votes
    function castVote(uint256 candidateIndex) public {
        require(!voters[msg.sender], "You have already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate index.");

        voters[msg.sender] = true;
        candidates[candidateIndex].voteCount++;
        emit VoteCasted(msg.sender, candidateIndex);
    }

    // Function to get the total number of candidates
    function getNumCandidates() public view returns (uint256) {
        return candidates.length;
    }

    // Function to get the details of a specific candidate
    function getCandidate(uint256 candidateIndex) public view returns (string memory name, uint256 voteCount) {
        require(candidateIndex < candidates.length, "Invalid candidate index.");
        return (candidates[candidateIndex].name, candidates[candidateIndex].voteCount);
    }
}