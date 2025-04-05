// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract BasicLottery {
    address[] public players;

    // Function to enter the lottery by sending 0.01 ether
    function enter() public payable {
        require(msg.value == 0.01 ether, "Entry fee is 0.01 ether");
        players.push(msg.sender);  // Add the sender to the players array
    }

    // Function to randomly select a winner and send the prize to the winner
    function pickWinner() public {
        require(players.length > 0, "No players entered");

        uint winnerIndex = random() % players.length;  // Random index
        address winner = players[winnerIndex];

        // Transfer the contract's balance (prize) to the winner
        payable(winner).transfer(address(this).balance);

        // Reset the players array for the next lottery round
        delete players;
    }

    // Helper function to generate a pseudo-random number based on the block data
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players)));
    }

    // Function to get the number of players currently in the lottery
    function getPlayersCount() public view returns (uint) {
        return players.length;
    }

    // Function to check the balance of the contract
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Fallback function to receive ether directly
    receive() external payable {}
}
