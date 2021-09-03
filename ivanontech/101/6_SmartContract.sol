pragma solidity 0.7.5;

contract SC6 {
    
    // error handling(require, assert), mapping, modifier, event, private function
    
    mapping(address => uint) balance;
    address public owner;
    
    event balanceAdded(uint amount, address indexed to);
    event Transfer(address from, address to, uint amount);
    
    modifier onlyOwner {
        require(msg.sender == owner, "Available only for Owner.");
        _; // run the function
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function addBalance(uint _toAdd) public onlyOwner returns (uint) {
        balance[msg.sender] += _toAdd;
        
        emit balanceAdded(_toAdd, msg.sender);
        
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }
    
    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient.");
        require(msg.sender != recipient, "Don't transfer coins to yourself.");
        
        uint previousSenderBalance = balance[msg.sender];
        
        _transfer(msg.sender, recipient, amount);
        
        emit Transfer(msg.sender, recipient, amount);
        
        assert(balance[msg.sender] == previousSenderBalance - amount);
    }
    
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}