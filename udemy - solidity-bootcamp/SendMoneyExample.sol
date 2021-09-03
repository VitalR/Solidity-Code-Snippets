pragma solidity ^0.5.17;

contract SendMoneyExample {
    
    uint public balanceReceived;
    
    // payable as it receive money
    function receiveMoney() public payable {
        balanceReceived += msg.value;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function withdrawMoney() public {
        address payable to = msg.sender; // the address of receiver money
        to.transfer(this.getBalance());
    }
    
    // to set up the address of withdrawal
    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
}