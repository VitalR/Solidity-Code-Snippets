pragma solidity ^0.4.10;

// https://peckshield.medium.com/alert-new-batchoverflow-bug-in-multiple-erc20-smart-contracts-cve-2018-10299-511067db6536
// _value = 0x8000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000(63 0’s);
// 0x8000000000000000000000000000000000000000000000000000000000000000

contract Overflow {
    
    mapping(address => uint) balances;
    
    function contribute() public payable {
        balances[msg.sender] = msg.value;
    }
    
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
    
    function batchSend(address[] _receivers, uint _value) public {
        // this line overflow
        uint total = _receivers.length * _value;
        require(balances[msg.sender] >= total);
        
        // subtract from sender
        balances[msg.sender] -= total;
        
        for(uint i = 0; i < _receivers.length; i++) {
            balances[_receivers[i]] += _value;
        }
    }
}