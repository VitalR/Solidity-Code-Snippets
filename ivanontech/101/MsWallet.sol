pragma solidity 0.7.5;
pragma abicoder v2;

contract Wallet {
    
    address[] owners;
    uint8 limit;
    
    struct Transfer {
        uint amount;
        address payable receiver;
        uint approvals;
        bool hasBeenSent;
        uint id;
    }
    
    event TransferRequestCreated(uint _id, uint _amount, address _initiator, address _receiver);
    event ApprovalReceived(uint _id, uint _approvals, address _apprever);
    event TransferApproved(uint _id);
    
    Transfer[] transferRequests;
    
    mapping(address => mapping(uint => bool)) approvals;
    
    modifier onlyOwners() {
        bool owner = false;
        for(uint i = 0; i < owners.length; i++) {
            if (owners[i] == msg.sender) {
                owner = true;
            } 
        }
        require(owner = true);
        _;
    }
    
    constructor(address[] memory _owners, uint8 _limit) public {
        owners = _owners;
        limit = _limit;
    }

    // Empty function
    function deposit() public payable {
        
    }
    
    // Create and instance of the Transfer struct and add it to the transferRequest array
    function createTransfer(uint _amount, address payable _receiver) public onlyOwners {
        require(address(this).balance >= _amount, "Unable to create Transfer Request greater than Contrace balance.");
        
        emit TransferRequestCreated(transferRequests.length, _amount, msg.sender, _receiver);
        
        Transfer memory newTransfer = Transfer({
            amount: _amount,
            receiver: _receiver,
            approvals: 0,
            hasBeenSent: false,
            id: transferRequests.length
        });
        
        transferRequests.push(newTransfer);
    }
    
    // Set your approval for one of the transfer requests.
    // Need to update the Transfer object.
    // Need to update the mapping to recort the approval for the msg.sender.
    // When the amount of approvals for a transfer has reached the limit, this function should send the transfer to the receiver.
    // An owner should not be able to vote twice.
    // An owner should not be able to voete on a transfer request that already been sent.
    function approve(uint _id) public onlyOwners {
        Transfer storage transfer = transferRequests[_id];
 
        require(approvals[msg.sender][_id] == false);
        require(transfer.hasBeenSent == false);
        
        approvals[msg.sender][_id] = true;
        transfer.approvals++;
        
        emit ApprovalReceived(_id, transfer.approvals, msg.sender);
        
        if(transfer.approvals >= limit) {
            transfer.hasBeenSent = true;
            transfer.receiver.transfer(transfer.amount);
            
            emit TransferApproved(_id);
        }
    }
    
    // Should return all transfer requests
    function getTransferRequests() public view returns (Transfer[] memory) {
        return transferRequests;
    }
    
    // Should show total wallet balance
    function getWalletBalance() public view returns (uint) {
        return address(this).balance;
    }

}