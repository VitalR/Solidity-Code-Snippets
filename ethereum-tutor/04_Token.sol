pragma solidity ^0.5.1;

contract MyContract {
    address payable wallet;
    mapping(address => uint256) public balances;
    
    event Purchase(address indexed _buyer, uint256 _amount);
    
    constructor(address payable _wallet) public {
        wallet = _wallet;
    }
    
    function() external payable {
        buyToken();
    }
    
    function buyToken() public payable {
        // buy buyToken
        balances[msg.sender]++;
        // send ether to the wallet
        wallet.transfer(msg.value);
        emit Purchase(msg.sender, 1);
    }
}