pragma solidity 0.7.5;

// Code snipped

contract Test {
    
    // Sending Ether safely
    
    yourAddress.send(x);
    // Safe against re-entrency
    // 2300 Gas Stipend
    
    yourAddress.transfer(x);
    // Safe against re-entrency
    // Same as send() but with a built in require()
    // Revert on failure
    
    yourAddress.call.value(x)()
    // Unlimited gas to fallback function
    
    
}