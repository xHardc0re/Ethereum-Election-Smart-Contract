// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    uint public candidatesCount;

    // Event to notify when a vote has been cast
    event VotedEvent (
        uint indexed _candidateId
    );

    // Constructor to add candidates
    constructor() {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    // Function to add a new candidate
    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Function to cast a vote
    function vote(uint _candidateId) public {
        // Require that the voter hasn't voted before
        require(!voters[msg.sender], "You have already voted.");

        // Require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");

        // Record that the voter has voted
        voters[msg.sender] = true;

        // Update candidate vote count
        candidates[_candidateId].voteCount++;

        // Trigger the voted event
        emit VotedEvent(_candidateId);
    }
}