pragma solidity 0.7.5;

contract Bank {
    
    // error handling(require, assert), mapping, modifier, event, private function
    // payable
    
    mapping(address => uint) balance;
    address public owner;
    
    event DepositDone(uint amount, address indexed to);
    event Transfer(address from, address to, uint amount);
    
    modifier onlyOwner {
        require(msg.sender == owner, "Available only for Owner.");
        _; // run the function
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function deposit() public payable returns (uint) {
        balance[msg.sender] += msg.value;
        
        emit DepositDone(msg.value, msg.sender);
        
        return balance[msg.sender];
    }
    
    function withdraw(uint amount) public returns (uint) {
        require(balance[msg.sender] >= amount, "Unable withdraw more then your deposit.");
        balance[msg.sender] -= amount;
        msg.sender.transfer(amount);
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