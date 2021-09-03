pragma solidity 0.8.0;

contract simpleList {

  struct EntityStruct {
    address entityAddress;
    uint entityData;
  }

  EntityStruct[] public entityStructs;

    // execution cost	66785 gas 51785 gas 51785 gas 51785 gas 
  function newEntity(address entityAddress, uint entityData) public returns(EntityStruct memory) {
    EntityStruct memory newEntity;
    newEntity.entityAddress = entityAddress;
    newEntity.entityData    = entityData;
    entityStructs.push(newEntity);
    return entityStructs[entityStructs.length - 1];
  }
  
    //   execution cost	9475 gas 13675 gas 9475 gas 13675 gas 9475 gas
  function updateEntity(uint rowNumber, address entityAddress, uint entityData) public returns(bool success) {
    entityStructs[rowNumber].entityAddress = entityAddress;
    entityStructs[rowNumber].entityData    = entityData;
    return true;
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityStructs.length;
  }
}