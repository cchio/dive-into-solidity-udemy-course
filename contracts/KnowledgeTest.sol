//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract KnowledgeTest {

    modifier onlyOwner {
        require(
            msg.sender == owner, 
            "ONLY_OWNER"
        );
        _;
    }

    string[] public tokens = ["BTC", "ETH"];
    address[] public players;

    // Has an owner variable that is public
    address public owner;

    constructor () {
        // Initializes the owner variable to the deployer
        owner = msg.sender;
    }

    // changeTokens() changes the state of the variable 'tokens'
    function changeTokens() external {
        string[] storage t = tokens;
        t[0] = "VET";
    }

    // Contract can receive ETH
    receive () external payable {}
    fallback () external payable {}

    // Gets the balance of the contract
    function getBalance () public view returns (uint) {
        return address(this).balance;
    }

    // Only owner can call transferAll()
    function transferAll (address payable destination) onlyOwner public returns (bool, bytes memory) {
        // transferAll() sends all the ether in the contract to another address
        (bool success, bytes memory returnBytes) = destination.call{value: getBalance()}("");
        return (success, returnBytes);
    }

    // start() adds the calling address to 'players
    function start () public {
        players.push(msg.sender);
    }

    // concatenate() returns two strings concatenated
    // reference: https://ethereum.stackexchange.com/a/56337/28419
    function concatenate (string memory a, string memory b) public pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

}
