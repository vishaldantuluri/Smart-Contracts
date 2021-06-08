// SPDX-License-Identifier: RANDOM_TEXT

pragma solidity ^0.8.1;

struct Payment{
    uint amount;
    uint timestamp;
}

struct Balance{
    uint totalBalance;
    uint numPayments;
    mapping(uint => Payment) pay;
}

contract myContract{
    mapping(address => Balance) public ethMapping;
    
    
    function pullEther() public payable{
        ethMapping[msg.sender].totalBalance += msg.value;
        Payment memory temp = Payment(msg.value, block.timestamp);
        ethMapping[msg.sender].pay[ethMapping[msg.sender].numPayments] = temp;
        ethMapping[msg.sender].numPayments ++;
    }
    
    function withdrawAll(address payable _to) public{
        _to.transfer(ethMapping[msg.sender].totalBalance);
        ethMapping[_to].totalBalance += ethMapping[msg.sender].totalBalance;
        ethMapping[msg.sender].totalBalance = 0;
       
    }
    
    function withdraw(address payable _to, uint sum) public {
        _to.transfer(sum);
        ethMapping[_to].totalBalance += sum;
        ethMapping[msg.sender].totalBalance -= sum;
       
    }
}