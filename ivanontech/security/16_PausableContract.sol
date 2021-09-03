pragma solidity ^0.8.0;

contract Bank {
    
    address owner;
    mapping(address => uint256) balanses;
    bool private _paused;
    
    constructor () {
        _paused = false;
    }
    
    // Allow to execute when contract is not paused
    modifier whenNotPaused() {
        require(!_paused);
        _;
    }
    
    modifier whenPaused() {
        require(_paused);
        _;
    }
        
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    
    function pause() public onlyOwner whenNotPaused {
        _paused = true;
    }
    
    function unPaused() public onlyOwner whenPaused {
        _paused = false;
    }
    
    function withdrawAll() public payable whenNotPaused {
        uint256 amountToWithdraw = balanses[msg.sender];
        balanses[msg.sender] = 0;
        msg.sender.call{value: amountToWithdraw};
    }
    
    function emergencyWithdraw(address emergencyWithdraw) public onlyOwner whenPaused {
        // emergencyWithdraw functionality
    }
    
}