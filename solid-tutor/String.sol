pragma solidity ^0.5.0;

contract MyContract {
    // String is dynamic array in Solidity
    string a = "Hello";
    string b = " world!";
    
    // Concatenate two strings
    // string public z = a + b; // error
    string public c = string(abi.encodePacked(a, b));
    
    // Length of the string
    bytes byteStr = bytes(c);
    uint public length = byteStr.length;
    
    // How get a hash of multiple values
    bytes32 public hashy = keccak256(abi.encodePacked(a, b, c));
    
    // How to generate a random integer
    uint256 public random = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)));
    
}