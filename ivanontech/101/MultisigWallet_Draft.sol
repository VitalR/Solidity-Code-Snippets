pragma solidity 0.7.5;

contract MultisigWallet {
    
    struct TransferRequest {
        uint amount;
        address payable receiver;
        uint approvalCount;
        mapping(address => bool) requestApprovals;
    }
    
    // mapping (uint => Request) requests; Request storage newRequest = requests[index];
    // mapping(uint => TransferRequest) transferRequests;
    
    TransferRequest[] public transferRequests;
    address[] owners;
    uint numberOfApprovals;
    
    mapping(address => uint) balance;
    
    modifier onlyOwners() {
        require(msg.sender == owners[0] || msg.sender ==  owners[1] || msg.sender ==  owners[2]);
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
        newTransferRequest.approvalCount = 0;
       
    
        // Request storage newRequest = requests.push();
        // newRequest.description = description;
        
        
        
        // TransferRequest storage newTransferRequest = transferRequests({
        //     amount: _amount,
        //     receiver: _receiver,
        //     approvalCount: 0
        // });
        
        // transferRequests.push(newTransferRequest);
    }
    
    function approveTransferRequest(uint index) public onlyOwners {
        TransferRequest storage request = transferRequests[index];
        
        require(!request.requestApprovals[msg.sender], "You are already applroved.");
        
        transferRequests[index].approvalCount++;
    }
    
    function completeTransferRequest(uint index) public onlyOwners {
        TransferRequest storage request = transferRequests[index];
        
        require(request.approvalCount >= 2, "Request should have equal or more than 2 approvals.");
        
        request.receiver.transfer(request.amount);
    }
    
}