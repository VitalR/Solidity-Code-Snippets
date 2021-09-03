pragma solidity ^0.5.1;


contract ERC20Token {
    string public name;
    mapping(address => uint256) public balances;
    
    function mint() public {
        // balances[msg.sender] ++;
        balances[tx.origin] ++;
    }
}

contract MyContract {
    
    address payable public wallet;
    address public token;
    
    // set a wallet
    constructor(address payable _wallet, address _token) public {
        wallet = _wallet;
        token = _token;
    }

    function() external payable {
        buyToken();
    }

    function buyToken() public payable {
        ERC20Token(address(token)).mint();
        // ERC20Token _token = ERC20Token(address(token));
        // _token.mint();
        wallet.transfer(msg.value);
    }
}

