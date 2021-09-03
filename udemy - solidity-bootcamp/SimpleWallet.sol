pragma solidity  ^0.6.0 <0.8.0;

import "./SimpleWalletAllowance.sol";

contract SimpleWallet is Allowance {
    
    event CoinsSent(address indexed _beneficiary, uint _amount);
    event CoinsReceived(address indexed _from, uint _amount);
    
    function withdrawCoins(address payable _to, uint _amount) public ownerOrAllowance(_amount) {
        require(_amount <= address(this).balance, "There are not enough funds stored in the Smart Contract.");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit CoinsSent(_to, _amount);
        _to.transfer(_amount);
    }
    
    function renounceOwnership() public override onlyOwner {
        revert("Unable to renounce ownership here.");
    }
    
    receive () external payable {
        emit CoinsReceived(msg.sender, msg.value);
    }
    
    
    
    // address payable owner;
    
    // constructor() public {
    //     owner = msg.sender;
    // }
    
    // modifier onlyOwner {
    //     require(owner == msg.sender, "Not Allowed. You are not owner!");
    //     _;
    // }
    
    // mapping(address => uint) public allowance;
    
    // function setAllowance(address _who, uint _amount) public onlyOwner {
    //     allowance[_who] = _amount;
    // }
    
    // modifier ownerOrAllowance(uint _amount) {
    //     require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed!");
    //     _;
    // }
    
    // function reduceAllowance(address _who, uint _amount) internal {
    //     allowance[_who] -= _amount;
    // }
}