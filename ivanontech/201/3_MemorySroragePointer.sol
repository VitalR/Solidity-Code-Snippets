pragma solidity 0.7.5;

contract SC {
    
    uint[] storageArray; // [1, 2, 3]
    
    // Assign by copy
    // Assign by reference | pointer
    
    // storage -> memory = COPY
    // memory -> storage = COPY
    
    // memory -> memory = REFERENCE
    // storage -> local storage = REFERENCE
    
        
    function func(uint[] memory memoryArray) public { // [1, 2, 3, 4]
        storageArray = memoryArray; // copy memoryArray to storageArray
        memoryArray.push(4);
        
        uint[] storage pointerArray = storageArray; // pointerArray => storageArray
        
        pointerArray.push(7); // push into storageArray
        
        // uint[] memory memoryArray2 = memoryArray; // memoryArray2 -> memoryArray
        // if memoryArray2 is changed => memoryArray also be changed, 
        // because memoryArray2 is not a copy, but reference(pointer) of memoryArray
        // if modify reference => modify original source
        
        memoryArray = pointerArray; // copy [1, 2, 3, 7] to memoryArray
        
    }
    
}