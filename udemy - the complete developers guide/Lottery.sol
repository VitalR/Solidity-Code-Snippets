pragma solidity ^0.4.25;

contract Lottery {
    address public manager;
    address[] public players;
    uint256 public prizePool;
    address public winner;
    
    constructor() public {
        manager = msg.sender;
    }
    
    modifier onlyManager() {
        require(msg.sender == manager, "Available only for Manager!");
        _;
    }
    
    function enterPlayer() public payable {
        require(msg.value >= 1 ether, "Put 1 ether to take a part in Lottery");
        prizePool += msg.value;
        
        players.push(msg.sender);
    }
    
    // pseude random
    function random() private view returns (uint) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, now, players)));
    }
    
    function pickWinner() public onlyManager {
        uint index = random() % players.length;
        players[index].transfer(this.balance); // this.balance - all coins in this particular contract
        winner = players[index];
        players = new address[](0); // no elements in array; clean players to start new Lottery;  
        prizePool = 0;
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}