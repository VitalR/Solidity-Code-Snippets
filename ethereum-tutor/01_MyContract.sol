pragma solidity ^0.5.1;

contract MyContract {
    enum State { Waiting, Ready, Active }
    State public state;
    
    // string public value;
    
    constructor() public {
        state = State.Waiting;
    }
    
    // function set(string memory _value) public {
    //     value = _value;
    // }
    
    function activate() public {
        state = State.Active;
    }
    
    function ready() public {
        state = State.Ready;
    }
    
    function isActive() public view returns(bool) {
        return state == State.Active;
    }
    
    function isReady() public view returns(bool) {
        return state == State.Ready;
    }
}
