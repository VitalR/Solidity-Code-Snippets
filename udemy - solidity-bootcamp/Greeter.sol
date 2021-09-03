pragma solidity ^0.4.21;

contract Greeter {
    string public greeting;
    
    function Greeter() public {
        greeting = 'Hello';
    }
    
    function setGreeting(string _greeting) public {
        greeting = _greeting;
    }
    
    function greet() view public returns (string) {
        return greeting;
    }
}

# Set Env to ganache 7545
# 0x98bA59009360a861E1339221CF0E6723345C2BD0