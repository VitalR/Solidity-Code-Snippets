pragma solidity 0.5.1;

import "./13_Storage.sol";

contract Dogs is Storage {

    function getNumberOfDogs() public view returns (uint) {
        return Storage.getNumber();
    }
    
    function setNumberOfDogs(uint toSet) public {
        Storage.setNumber(toSet + 1);
    } 
    
}