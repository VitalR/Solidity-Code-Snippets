pragma solidity 0.7.5;

// Code snipped

contract Test {
    
    // Calling external functions
    // We are calling from Contract A -> Contract B
    
    ContractB.call();
    // Call function in External Contract
    // Using Contract B scope
    // Throws no error if it fails
    // Returns true/false
    
    ContractB.callcode();
    // Call function in External Contract
    // Using Contract A scope
    // Throws no error if it fails
    // Returns true/false
    
    ContractB.delegatecall();
    // Call function in External Contract
    // Using Contract A scope
    // Throws no error if it fails
    // Returns true/false
    
    ContractB.runFunction();
    // ContractB.functionA();
    // Call function in External Contract
    // Using Contract B scope
    // Will throw if runFunction() throws
    
    ContractB.call(bytes4(sha3("runFunction(uint256)")), 100)
    
}