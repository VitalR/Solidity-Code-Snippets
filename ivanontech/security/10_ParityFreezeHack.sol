pragma solidity ^0.4.10;

import "./11_Library.sol";

contract Fundraiser {
    
    Library lib = Library(0x77eC7CE5224728226F56f2b33ac9Aa5D0A368018);
    
    mapping(address => uint) balances;
    
    function contribute() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw() public payable {
        if(lib.isNotPositive(balances[msg.sender])) {
            throw;
        }
        
        balances[msg.sender] = 0;
        msg.sender.call.value(balances[msg.sender])();
       
    }
    
    function getFunds() public returns (uint) {
        return address(this).balance;
    }
}