pragma solidity ^0.5.17;

contract Wallet {
    
    mapping(address => uint) balanceReceived;
    // uint public balanceReceived;
    
    uint public maxAllowance;
    
    address payable owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function getOwner() public view returns(address) {
        return owner;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function setMaxAllowance(uint _amount) public {
        require(msg.sender == owner, "Not Allowed. You are not an owner!");
        maxAllowance = _amount;
    }
    
    function depositCoins() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawUnlimited(address payable _to) public payable {
        require(msg.sender == owner, "Not Allowed. You are not an owner!");
        uint balanceSend  = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceSend);
    }
    
    function withdrawCoins(address payable _to, uint _amount) public payable {
        require(maxAllowance >= _amount, "You are not allowed withdraw more then maxAllowance.");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
        
    }
    
}