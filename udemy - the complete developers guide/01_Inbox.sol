pragma solidity ^0.5.1;

contract Inbox {
    string public message;
    
    constructor(string memory initialMessage) public {
        message = initialMessage;
    }
    
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }
    
    // function getMessage() public view returns (string memory) {
    //     return message;
    // }
}

//0xf8e81D47203A594245E36C48e151709F0C19fBe8

