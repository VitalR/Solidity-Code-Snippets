pragma solidity 0.7.5;

contract Test {
    
    // Checks - Effects - Interactions Pattern
    // Insecure code
    mapping(address => uint) balances;
    
    // Wrong pattern
    function withdrawAllWrongPattern() public {
        // Check
        uint amountToWithdraw = balances[msg.sender];
        // Interaction
        require(msg.sender.call.value(amountToWithdraw)());
        // Effects
        balances[msg.sender] = 0;
    }
    
    // Correct pattern
    function withdrawAll() public {
        // Check
        uint amountToWithdraw = balances[msg.sender];
        // Effects
        balances[msg.sender] = 0;
        // Interaction
        require(msg.sender.call.value(amountToWithdraw)());
    }
}