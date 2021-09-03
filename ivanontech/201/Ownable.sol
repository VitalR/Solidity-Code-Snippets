pragma solidity 0.7.5;

contract Ownable {
    
    address internal owner;
    
    modifier onlyOwner {
        require(msg.sender == owner, "Available only for Owner.");
        _; // run the function
    }
    
    constructor() {
        owner = msg.sender;
    }
}