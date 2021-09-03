pragma solidity 0.5.1;

contract Storage {
    
    uint number;
    
    function getNumber() public view returns (uint) {
        return number;
    }
    
    function setNumber(uint _number) internal {
        number = _number;
    } 
    
}