pragma solidity ^0.5.17;

contract MappingStructExample {
    
    struct Payment {
        uint amount;
        uint timestamps;
    }
    
    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }
    
    mapping(address => Balance) public balanceReceived;
    //mapping(address => uint) public balanceReceived;
    
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function sendMoney() public payable {
        Payment memory payment = Payment(msg.value, now);
        
        balanceReceived[msg.sender].totalBalance += msg.value;
       
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments++] = payment;
        //balanceReceived[msg.sender].numPayments++;
        
        // address addressKey = msg.sender;
        // uint currentPaymentIndex = moneyReceived[addressKey].numPayments;
        // moneyReceived[addressKey].payments[currentPaymentIndex] = payment;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(balanceReceived[msg.sender].totalBalance >= _amount, "Not enough funds");
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }
    
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
        //_to.transfer(address(this).balance);
    }
}