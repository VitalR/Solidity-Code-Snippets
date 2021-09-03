pragma solidity 0.7.5;

import "./11_Ownable.sol";

contract Destroyable is Ownable {
    
    function destroy() public onlyOwner {
        address payable receiver = msg.sender;
        selfdestruct(receiver);  // `receiver` is the owners address
    }    
    
}

