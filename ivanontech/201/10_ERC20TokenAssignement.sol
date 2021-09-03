pragma solidity 0.7.5;

import "./SafeMath.sol";

contract ArtToken {
    
    using SafeMath for uint;
    
    string internal tokenName;
    string internal tokenSymbol;
    uint internal tokenDecimals;
    uint internal tokenTotalSupply;
    
    mapping (address => uint) internal balances;
    mapping (address => mapping (address => uint)) internal allowed;
    
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);
    
    constructor(string memory _name, string memory _sybol, uint _decimals, uint _initialOwnerBalance) {
        tokenName = _name;
        tokenSymbol = _sybol;
        tokenDecimals = _decimals;
        tokenTotalSupply = _initialOwnerBalance;
        balances[msg.sender] = _initialOwnerBalance;
    }
    
    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }
    
    function transfer(address payable receiver, uint numTokens) public returns (bool) {
        require(balances[msg.sender] >= numTokens);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }
    
    // Allows spender to withdraw from your account multiple times, up to the _value amount.
    // If this function is called again it overrites the current allowance with _value.
    function approve(address spender, uint numTokens) public returns (bool) {
        allowed[msg.sender][spender] = numTokens;
        emit Approval(msg.sender, spender, numTokens);
        return true;
    }
    
    // Returns the amount which spender is still allowed to withdraw from owner.
    function allowance(address tokenOwner, address spender) external view returns (uint remaining) {
        remaining = allowed[tokenOwner][spender];
    }

    // Transfer value amount of tokens from tokenOwner to address buyer
    function transferFrom(address tokenOwner, address buyer, uint numTokens) public returns (bool) {
        require(balances[tokenOwner] >= numTokens);
        require(allowed[tokenOwner][msg.sender] >= numTokens);
        
        balances[tokenOwner] = balances[tokenOwner].sub(numTokens);
        allowed[tokenOwner][msg.sender] = allowed[tokenOwner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(tokenOwner, buyer, numTokens);
        return true;
    }
}