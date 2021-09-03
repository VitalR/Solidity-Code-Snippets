pragma solidity ^0.5.17;

contract DebuggerExample {
    uint public myUint;
    
    function setMyUint(uint _myuint) public {
        myUint = _myuint;
    }
}

//0x06540f7e
// 0xe492fd840000000000000000000000000000000000000000000000000000000000000005
// 0x06540f7e

// ABI
// [
// 	{
// 		"constant": true,
// 		"inputs": [],
// 		"name": "myUint",
// 		"outputs": [
// 			{
// 				"internalType": "uint256",
// 				"name": "",
// 				"type": "uint256"
// 			}
// 		],
// 		"payable": false,
// 		"stateMutability": "view",
// 		"type": "function"
// 	},
// 	{
// 		"constant": false,
// 		"inputs": [
// 			{
// 				"internalType": "uint256",
// 				"name": "_myuint",
// 				"type": "uint256"
// 			}
// 		],
// 		"name": "setMyUint",
// 		"outputs": [],
// 		"payable": false,
// 		"stateMutability": "nonpayable",
// 		"type": "function"
// 	}
// ]