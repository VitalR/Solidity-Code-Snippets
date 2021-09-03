pragma solidity 0.7.5;

contract MultisigWallet {
    
    struct TransferRequest {
        uint amount;
        address payable receiver;
        uint approvalCount;
        bool completed;
        mapping(address => bool) requestApprovals;
    }
    
    TransferRequest[] public transferRequests;
    address[] public owners;
    uint numberOfApprovals;
    
    mapping(address => uint) balance;
    
    modifier onlyOwners() {
        require(msg.sender == owners[0] || msg.sender ==  owners[1] || msg.sender ==  owners[2], "Available only for Owners.");
        _;
    }
    
    constructor(address _owner1, address _owner2, address _owner3, uint _numberOfApprovals) public {
        owners.push(_owner1);
        owners.push(_owner2);
        owners.push(_owner3);
        numberOfApprovals = _numberOfApprovals;
    }
    
    function deposit() public payable returns (uint) {
        balance[msg.sender] += msg.value;
        return balance[msg.sender];
    }
    
    function createTransferRequest(uint _amount, address payable _receiver) public onlyOwners {
        TransferRequest storage newTransferRequest = transferRequests.push();
        newTransferRequest.amount = _amount;
        newTransferRequest.receiver = _receiver;
        newTransferRequest.completed = false;
        newTransferRequest.approvalCount = 0;
    }
    
    function approveTransferRequest(uint index) public onlyOwners {
        TransferRequest storage request = transferRequests[index];
        
        require(!request.requestApprovals[msg.sender], "Request has been approved by you.");
        
        request.requestApprovals[msg.sender] = true;
        request.approvalCount++;
    }
    
    function completeTransferRequest(uint index) public onlyOwners {
        TransferRequest storage request = transferRequests[index];
        
        require(!request.completed, "Request is already completed.");
        require(request.approvalCount >= 2, "Request should have equal or more than 2 approvals.");
        
        request.receiver.transfer(request.amount);
        request.completed = true;
    }
    
}