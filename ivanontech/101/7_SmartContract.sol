pragma solidity 0.7.5;

contract DataLocation {
    
    // storage - persistent data storage; exist before and after execution, stored permanently
    // memory - temporary data storage; stored during function execution
    // calldata - similar to memory, but READ-ONLY; cost less gas so cheaper
    
    // state variabel
    uint data = 123; // stored in storage
    
    
    
    function getString(string memory text) public pure returns(string memory) {
        return text;
    }
}