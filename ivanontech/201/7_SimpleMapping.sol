pragma solidity 0.8.0;
contract mappingWithStruct {

  struct EntityStruct {
    uint entityData;
    bool isEntity;
  }

  mapping (address => EntityStruct) public entityStructs;

    // execution cost	42964 gas 42964 gas 42964 gas 42964 gas 42964 gas
  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert(); 
    entityStructs[entityAddress].entityData = entityData;
    entityStructs[entityAddress].isEntity = true;
    return true;
  }
  
  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    return entityStructs[entityAddress].isEntity;
  }

  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].isEntity = false;
    return true;
  }

    // execution cost	6910 gas 6910 gas ... ... ... 6910 gas
  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }
}