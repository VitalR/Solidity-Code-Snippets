pragma solidity ^0.5.17;

contract ExceptionExample {
    
    mapping(address => uint64) public balanceReceived;
    
    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    }
    
    function withdrawMoney(address payable _to, uint64 _amount) public {
        require(balanceReceived[msg.sender] >= _amount, "Not enough funds");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
        
        
        // if(balanceReceived[msg.sender] >= _amount) {
        //     balanceReceived[msg.sender] -= _amount;
        //     _to.transfer(_amount);
        // }
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}