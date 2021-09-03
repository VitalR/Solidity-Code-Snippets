pragma solidity 0.7.5;

// Code snipped - Pull vs Push

contract PullvsPush {
    
    // Push 
    // Push funds to user
    
    // Example of Push (Bad)
    
    function play() payable {
        // GAME LOGIC
        
        if(win) {
            player.transfer(prize);
        }
    }
    
    
    // Pull
    // Let user pull out funds themselves
    
    // Example of Pull (Good)
    
    mapping(address => uint) prizes;
    
    function play() public {
        // GAME LOGIC
        
        if(win) {
            prizes[player] = prize;
        }
    }
    
    function getPrize() public {
        uint prize = prizes[msg.sender];
        prizes[msg.sender] = 0;
        msg.sender.transfer(prize);
    }
    
}