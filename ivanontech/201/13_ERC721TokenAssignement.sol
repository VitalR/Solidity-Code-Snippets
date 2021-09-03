pragma solidity ^0.8.0;

contract Kittycontract {
    
    // Resume: This solution can help to reduce execution time, as looping through the ownedCats array, 
    // in case of deletion of a TokenID, will most certainly take less time than looping through the entire 
    // Kitties array of the contract just to return all TokenIDs owned. The downside of this solution is certainly 
    // that we have to bring in another linear function to remove a cat from the catsOwned array. 
    // Although it is possible that this newly created array grows to the same size as the Kittie Tokens Array, 
    // which stores all kittie structs ever created, it can be considered as rather unlikely. 
    // The big downside I see though is that the getAllCats function is view only, which is free. 
    // The createKitty and _transfer function though are costly functions that need gas. 
    // All in all, it is better to wait a little longer on a free function than to make a costly function more complex and more expensive.

    string public constant name = "TestKitties";
    string public constant symbol = "TK";
    
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    event Birth(
        address owner, 
        uint256 kittenId, 
        uint256 mumId, 
        uint256 dadId, 
        uint256 genes
    );

    struct Kitty {
        uint256 genes;
        uint64 birthTime;
        uint32 mumId;
        uint32 dadId;
        uint16 generation;
    }

    Kitty[] kitties;

    mapping (uint256 => address) public kittyIndexToOwner;
    // mapping (address => uint256) ownershipTokenCount;
    
    // map the owners address to the ids of the cats that he/she owns
    mapping(address => uint256[]) ownersCats;


    function balanceOf(address owner) external view returns (uint256 balance){
        // return ownershipTokenCount[owner];
        return ownersCats[owner].length;
    }

    function totalSupply() public view returns (uint) {
        return kitties.length;
    }

    function ownerOf(uint256 _tokenId) external view returns (address)
    {
        return kittyIndexToOwner[_tokenId];
    }

    function transfer(address _to, uint256 _tokenId) external
    {
        require(_to != address(0));
        require(_to != address(this));
        require(_owns(msg.sender, _tokenId));

        _transfer(msg.sender, _to, _tokenId);
    }
    
    function getAllCatsFor(address _owner) external view returns (uint[] memory cats){
        // just return the cats in the mapping for the given caller
        cats = ownersCats[_owner];
    }
    
    function createKittyGen0(uint256 _genes) public returns (uint256) {
        return _createKitty(0, 0, 0, _genes, msg.sender);
    }

    function _createKitty(
        uint256 _mumId,
        uint256 _dadId,
        uint256 _generation,
        uint256 _genes,
        address _owner
    ) private returns (uint256) {
        Kitty memory _kitty = Kitty({
            genes: _genes,
            birthTime: uint64(block.timestamp),
            mumId: uint32(_mumId),
            dadId: uint32(_dadId),
            generation: uint16(_generation)
        });
        
        kitties.push(_kitty);

        uint256 newKittenId = kitties.length - 1;

        emit Birth(_owner, newKittenId, _mumId, _dadId, _genes);

        _transfer(address(0), _owner, newKittenId);

        return newKittenId;

    }

    function _transfer(address _from, address _to, uint256 _tokenId) internal {

        // Map the cat to the new owner
        kittyIndexToOwner[_tokenId] = _to;
        
        // Push the id of the cat to the list if ids for the user
        ownersCats[_to].push(_tokenId);
        
        // Remove the id of the cat from the list of the precious order if it was not a newly generated cat
        if (_from != address(0)) {
            _removeOwnership(_from, _tokenId);
        }

        // Emit the transfer event.
        emit Transfer(_from, _to, _tokenId);
    }
    
    // Removes the id of the cat from the previous owners list
    function _removeOwnership(address _owner, uint256 _tokenId) internal {
        // Loop though the owned cats of the given address
        for (uint i = 0; i < ownersCats[_owner].length; i++) {
            
            // If the cat was found
            if (ownersCats[_owner][i] == _tokenId) {
                // Replace the cat by copying the last cat to this position
                ownersCats[_owner][i] = ownersCats[_owner][ownersCats[_owner].length-1];
                
                // Remove the duplicate
                ownersCats[_owner].pop();
                
                // Return from the function to save gas since we have done all we should
                return;
            }
        }
    }

    function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
      return kittyIndexToOwner[_tokenId] == _claimant;
  }

}