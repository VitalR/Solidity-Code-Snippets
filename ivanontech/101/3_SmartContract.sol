pragma solidity 0.7.5;

contract SC3 {
    
    int[3] public numbers;
    int[] public numbers2;
    
    
    // fix size array
    function addNumber() public {
        numbers[0] = 1;
        numbers[1] = 2;
        numbers[2] = 3;
    }
    
    // not fix size array
    function addNumbers(int _number) public {
        numbers2.push(_number);
    }
    
    function getNumber(uint _id) public view returns(int) {
        return numbers2[_id];
    }
    
    function getNumbers() public view returns(int[] memory) {
        return numbers2;
    }
}

