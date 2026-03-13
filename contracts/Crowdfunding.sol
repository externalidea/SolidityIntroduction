// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract CommunityFunding {
    struct Project {
        string name;
        string description;
        uint256 requestedAmount;
        uint256 votes;
        bool funded;
    }

    Project[] public projects;

    mapping(address => mapping(uint => bool)) public hasVoted;

    constructor() {
        projects.push(Project({
            name: "Clean Water Initiative",
            description: "Providing clean water to villages",
            requestedAmount: 5 ether,
            votes: 0,
            funded: false
        }));

        projects.push(Project({
            name: "Community Library",
            description: "Build a library with books and computers",
            requestedAmount: 3 ether,
            votes: 0,
            funded: false
        }));
    }

    function proposeProject(
        string memory _name,
        string memory _description,
        uint256 _requestedAmount
    ) public {
        projects.push(Project({
            name: _name,
            description: _description,
            requestedAmount: _requestedAmount,
            votes: 0,
            funded: false
        }));
    }

    function vote(uint _projectId) public {
        require(_projectId < projects.length, "Project does not exist");
        require(!hasVoted[msg.sender][_projectId], "Already voted for this project");

        projects[_projectId].votes += 1;
        hasVoted[msg.sender][_projectId] = true;
    }

    function distributeFunds() public payable {
        uint totalVotes = 0;

        for (uint i = 0; i < projects.length; i++) {
            totalVotes += projects[i].votes;
        }

        require(totalVotes > 0, "No votes cast");

        for (uint i = 0; i < projects.length; i++) {
            if (!projects[i].funded) {
                uint256 share = (msg.value * projects[i].votes) / totalVotes;
                if (share > projects[i].requestedAmount) {
                    share = projects[i].requestedAmount;
                }
                payable(msg.sender).transfer(share);  
                projects[i].funded = true;
            }
        }
    }

    function getProjectsCount() public view returns(uint) {
        return projects.length;
    }

    function getProject(uint _projectId) public view returns (
        string memory, string memory, uint256, uint256, bool
    ) {
        require(_projectId < projects.length, "Project does not exist");
        Project storage p = projects[_projectId];
        return (p.name, p.description, p.requestedAmount, p.votes, p.funded);
    }
}