pragma solidity  ^0.6.0 <0.8.0;

//import "Ownable.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0-beta.0/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";


contract Allowance is Ownable {
    
    using SafeMath for uint;
    
    event AllowanceChange(address indexed _forWho, address indexed _fromWho, uint oldAmount, uint newAmount);
    
    mapping(address => uint) public allowance;
    
    function setAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChange(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }
    
    modifier ownerOrAllowance(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }
    
    function reduceAllowance(address _who, uint _amount) internal {
        emit AllowanceChange(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }
}