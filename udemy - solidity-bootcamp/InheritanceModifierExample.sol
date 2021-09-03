pragma solidity ^0.5.17;

import "./Owned.sol";

// contract Owned {
//     address owner;
    
//     constructor() public {
//         owner = msg.sender;
//     }
    
//     modifier onlyOwner {
//         require(msg.sender == owner, "You are not allowed");
//         _;
//     }
// }

contract InheritanceModifiefExample is Owned {
    
    mapping(address => uint) public tokenBalance;
    
    //address owner;
    
    uint tokenPrice = 1 ether;
    
    constructor() public {
        // owner = msg.sender;
        tokenBalance[owner] = 100;
    }
    
    // modifier onlyOwner {
    //     require(msg.sender == owner, "You are not allowed");
    //     _;
    // }
    
    function createNewToken() public onlyOwner {
        //require(msg.sender == owner, "You are not allowed");
        tokenBalance[owner]++;
    }
    
    function burnToken() public onlyOwner {
        //require(msg.sender == owner, "You are not allowed");
        tokenBalance[owner]--;
    }
    
    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) > 0, "Not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }
    
    function sendToken(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }
    
}