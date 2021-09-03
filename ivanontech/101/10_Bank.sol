pragma solidity 0.7.5;

import "./11_Ownable.sol";
import "./12_Destroyable.sol";

interface GovernmentInterface {
    function addTransaction(address _from, address _to, uint _amount) external;
}

contract Bank is Ownable, Destroyable {
    
    // error handling(require, assert), mapping, modifier, event, private function
    // payable, internal, selfdestruct, external, interface
    
    GovernmentInterface governmentInstance = GovernmentInterface(0xf2B1114C644cBb3fF63Bf1dD284c8Cd716e95BE9);
    
    mapping(address => uint) balance;
    
    event DepositDone(uint amount, address indexed to);
    event Transfer(address from, address to, uint amount);
    
    function deposit() public payable returns (uint) {
        balance[msg.sender] += msg.value;
        
        emit DepositDone(msg.value, msg.sender);
        
        return balance[msg.sender];
    }
    
    function withdraw(uint amount) public onlyOwner returns (uint) {
        require(balance[msg.sender] >= amount, "Unable withdraw more then your deposit.");
        balance[msg.sender] -= amount;
        msg.sender.transfer(amount);
    }
    
    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }
    
    function getOwner() public view returns (address) {
        return owner;
    }
    
    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient.");
        require(msg.sender != recipient, "Don't transfer coins to yourself.");
        
        uint previousSenderBalance = balance[msg.sender];
        
        _transfer(msg.sender, recipient, amount);
        
        // governmentInstance.addTransaction{value: 1 wei}(msg.sender, recipient, amount);
        governmentInstance.addTransaction(msg.sender, recipient, amount);
        
        emit Transfer(msg.sender, recipient, amount);
        
        assert(balance[msg.sender] == previousSenderBalance - amount);
    }
    
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}