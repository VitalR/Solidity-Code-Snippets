pragma solidity 0.7.5;
pragma abicoder v2;


contract GasTest {
    
    //  execution cost	584 gas 
    function testExternal(uint[10] calldata numbers) external pure returns (uint) {
        return numbers[0];
    }
    
    
    // execution cost	3239 gas 
    function testPublic(uint[10] memory numbers) public view returns (uint) {
        return numbers[0];
    }
    
}