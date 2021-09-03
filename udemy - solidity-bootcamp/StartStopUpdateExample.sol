pragma solidity ^0.5.17;

contract StartStopUpdateExample {
    
    address owner;
    
    bool public paused;
    
    // the func that calls during deployment
    constructor() public {
        owner = msg.sender; // who create a TX to deploy to contract
    }
    
    // send ether to the contract
    function sendMoney() public payable {
        
    }
    
    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;
    }
    
    // withdraw the ether from the contract to the particular address
    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "The withdraw can be performed only by owner");
        require(!paused, "Contract is paused");
        _to.transfer(address(this).balance);
    }
    
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }
}