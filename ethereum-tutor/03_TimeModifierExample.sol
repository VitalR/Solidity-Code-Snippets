pragma solidity ^0.5.1;

contract MyContract {
    uint256 public peopleCount = 0;
    mapping(uint => Person) public people;
    
    uint256 openingTime = 1614612921; //1614602755
    
    uint public time = block.timestamp;
    
    modifier onlyWhileOpen() {
        require(block.timestamp >= openingTime, "Time for this contract has finished!");
        _;
    }
    
    struct Person {
        uint id;
        string _firstName;
        string _lastName;
    }
    
    // constructor() public {
    //     owner = msg.sender;
    // }
    
    function addPerson(string memory _firstName, string memory _lastName) public onlyWhileOpen {
        incrementCount();
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }
    
    function incrementCount() internal {
        peopleCount += 1;
    }
}