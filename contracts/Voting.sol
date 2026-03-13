// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.2 < 0.9.0;

contract Voting {
    string[] public candidates = ['Alex', 'Bob', 'Samantha'];

    mapping(string => uint256) public votes;
    
    function addCandidate(string memory name) public {
        candidates.push(name);
    }

    function vote(string memory name) public {
        bool valid = false;
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i])) == keccak256(bytes(name))) {
                valid = true;
                break;
            }
        }
        require(valid, "Candidate not found");
        votes[name] += 1; 
    }
    function getCandidates() public view returns (string[] memory){
        return candidates;
    }
    function getVotes(string memory name) view public returns(uint256){
        return votes[name];
    }
}