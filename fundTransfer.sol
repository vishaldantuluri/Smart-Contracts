// SPDX-License-Identifier: RANDOM_TEXT

pragma solidity ^0.8.1;

contract myContract {
    
    uint public balanceReceived;
    
    address public owner;
    
    constructor(){
        owner = msg.sender;
    }
    
    function Receive() public payable {
        balanceReceived += msg.value;
    }
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function withdraw(address payable _to) public{
        require(owner == msg.sender, 'you are not the owner!');
        _to.transfer(this.getBalance());
    }
    
    function withdraw() public {
        address payable to = payable(msg.sender);
        to.transfer(this.getBalance());
    }
    
    function destroy(address payable _to) public {
        require(owner == msg.sender, 'you are not the owner!');
        selfdestruct(_to);
    }
}