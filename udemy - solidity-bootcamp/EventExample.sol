pragma solidity ^0.5.17;

contract EventExample {
    
    mapping(address => uint) public tokenBalance;
    
    event TokenSend(address _from, address _to, uint _amount);
    
    constructor() public {
        tokenBalance[msg.sender] = 100;
    }
    
    function sendToken(address _to, uint _amount) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough funds.");
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
        
        emit TokenSend(msg.sender, _to, _amount);
        
        return true;
    }
}