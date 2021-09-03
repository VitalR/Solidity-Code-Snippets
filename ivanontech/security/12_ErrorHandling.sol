pragma solidity 0.7.5;

// CHECK, EFFECTS (changing state), INTERACTIONS - pattern

contract Test {
    
    // send and transfer 
    // 2300 gas stipend
    
    mapping(address => uint) balance;
    
    // WRONG pattern - UNSAFE
    function withdrawWrong() public {
        require(balance[msg.sender] > 0); // checks
        msg.sender.send(balance[msg.sender]); // interaction
        balance[msg.sender] = 0; // effects
    }
    
    // CORRECT pattern
    function withdraw() public {
        require(balance[msg.sender] > 0); // checks
        uint toTransfer = balance[msg.sender];
        balance[msg.sender] = 0; // effects
        // bool success = msg.sender.send(toTransfer); // interaction
        (bool success,) = msg.sender.call{value: toTransfer}("");
        if(!success) {
            balance[msg.sender] = toTransfer;
        }
    }
    
}