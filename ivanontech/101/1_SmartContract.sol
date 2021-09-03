pragma solidity 0.7.5;

contract HelloWorld {
    
    // state variables
    string message; // value of _message
    
    constructor(string memory _message) {
        message = _message;
    }
    
    // view func interact with state variables and doesn't edit/change state variables, 
    // just returns some value; read and returns
    function hello() public view returns(string memory) {
        // local variables
        return message;
    }
    
    // pure func doesn't interact with other part of SC; just returns
    function hellobasic() public pure returns(string memory) {
        return "Hi there!";
    }
    
    function ifStatement() public view returns(string memory) {
        if(msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4) {
            return message;
        } 
        else {
            return "Wrong address";
        }
    }
    
    function loopStatement(int number) public pure returns(int) {
        // int i = 0;
        // while(i < 10) {
        //     i++;
        // }
        // return i;
        
        for(int i = 0; i < 10; i++) {
            number++;
        }
        return number;
    }
    
}