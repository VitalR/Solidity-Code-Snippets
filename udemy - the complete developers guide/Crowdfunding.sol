pragma solidity ^0.4.25;

// Factory for creating crowdfunding campaine
contract CrowdfundingFactory {
    address[] public deployedCrowdfunging;
    
    function createCrowdfunding(uint _minimum) public {
        address newCrowdfunding = new Crowdfunding(msg.sender, _minimum);
        deployedCrowdfunging.push(newCrowdfunding);
    }
    
    function getDeployedCrowdfunding() public view returns (address[]) {
        return deployedCrowdfunging;
    }
}

// Crowdfunding campaine
contract Crowdfunding {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) requestApprovals;
    }
    
    Request[] public requests;
    address public manager;
    uint public minimunContrubution;
    mapping(address => bool) public approvers;
    uint public totalAmount;
    uint public approversCount;
    
    modifier onlyManager() {
        require(msg.sender == manager, "This available only for Manager.");
        _;
    }
    
    constructor(address _creater, uint _minimum) public {
        manager = _creater;
        minimunContrubution = _minimum;
    }
    
    function contribute() public payable {
        require(msg.value >= minimunContrubution);
        
        totalAmount += msg.value;
        approvers[msg.sender] = true;
        approversCount++;
    }
    
    function createRequest(string _description, uint _value, address _recipient) public onlyManager {
        Request memory newRequest = Request({
            description: _description,
            value: _value,
            recipient: _recipient,
            complete: false,
            approvalCount: 0
        });
        
        requests.push(newRequest);
    }
    
    function approveRequest(uint index) public {
        Request storage request = requests[index];
        
        require(approvers[msg.sender], "Available only for Contributors.");
        require(!request.requestApprovals[msg.sender], "You are already approved.");
        
        request.requestApprovals[msg.sender] = true;
        request.approvalCount++;
    }
    
    function finalizeRequest(uint index) public onlyManager {
        Request storage requist = requests[index];
        
        require(!requist.complete, "Request is already completed.");
        require(requist.approvalCount > (approversCount / 2), "Less then 50% approvals.");
        
        requist.recipient.transfer(requist.value);
        requist.complete = true;
        totalAmount--;
    }
}