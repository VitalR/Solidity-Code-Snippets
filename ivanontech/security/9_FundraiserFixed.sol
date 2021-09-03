pragma solidity ^0.4.10;

// DAO_Hack - Replicating the Vulnerability
// 1. What is DAO? A regular DAO stands for decentralized autonomous organization and is essentially an organization governed by code. The DAO (referring to the DAO hack) was a venture capital fund run by smart contracts.
// DAO was the first decentralized autonomous organization which is based on different interacting smart contracts. These smart contracts represents a governance mechanism. In short, the DAO was a venture capital fund where investors governing the DAO. All funds raised from the investors were pooled and you got an amount of token in proportion of your investment. Token holders could submit proposals for funding a project by using the DAO funds.
// 2. What function had the vulnerability? The split function held the vulnerability for the re-entry attack or “recursive call exploit.”
// The vulnerability was a re-entrency attack where the attack could change the control flow of the smart contract. To avoid suppressing the minority by the majority inside the smart contracts of the DAO a “protection function” (equivalent to appraisal right) was implemented where anybody could split the DAO in two (so called Child DAO). You have to submit a special form of proposal and then the minority could move their Ether into the new child DAO. 
// The split function contained the ability for a re entrency attack because inside the function because the effect (set balance/fund to 0) was checked after and not before sending the funds.
// 3. Why was the hard fork initiated? The hard fork was initiated because the DAO’s investors lost a lot of money and the majority of the community agreed they should do something–even though this violates the “code is law” ethos from whence Ethereum was founded.
// The hard fork was initiated because the majority agreed to it and they want to role the transaction back and refund the victims.
// The branch created with the hard-fork continued as the Ethereum whereas the old branch kept going as the Ethereum Classic.

contract Fundraiser {
    
    mapping(address => uint) balances;
    
    function contribute() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw() public {
        if(balances[msg.sender] == 0) {
            throw;
        }
        
        balances[msg.sender] = 0;
        msg.sender.call.value(balances[msg.sender])();
       
    }
    
    function getFunds() public returns (uint) {
        return address(this).balance;
    }
}