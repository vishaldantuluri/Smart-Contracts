// SPDX-License-Identifier: RANDOM_TEXT

pragma solidity ^0.8.1;

 import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract sharedWallet{
    
    using SafeMath for uint;
    
    uint public walletBalance;
    uint public allowance = 2 ether;
    uint public amountWithdrawn;
    address public owner;
    
    event withdrawn(
        address from,
        address to,
        uint amount
        );
        
    event deposited(
        address from,
        address to
        );
    
    constructor(){
        
        owner = msg.sender;
        walletBalance = 0;
        amountWithdrawn = 0;
    }
    
    modifier forOwner{
        
        require(msg.sender == owner, 'You are not the owner');
        _;
    }
    
    function deposit() public payable{
        
        walletBalance = walletBalance.add(msg.value);
        emit deposited(msg.sender, address(this));
    }
    
    receive() external payable{
        
        walletBalance = walletBalance.add(msg.value);
    }
    
    function setAllowance(uint _value) public forOwner{
        
        allowance = _value;
        
    }
    
    function withdrawOwner(address payable _to, uint _value) public forOwner {
        
        require(_value <= walletBalance, 'You do not have enough wallet balance');
        walletBalance = walletBalance.sub(_value);
        _to.transfer(_value);
        emit withdrawn(msg.sender, _to, _value);
        
    }
    
    function withdraw(address payable _to, uint _value) public{
        
        require(amountWithdrawn + _value <= allowance, 'You are exeeding the allowance');
        require(_value <= walletBalance, 'You do not have enough wallet balance');
        amountWithdrawn = amountWithdrawn.add(_value);
        walletBalance = walletBalance.sub(_value);
        _to.transfer(_value);
        emit withdrawn(msg.sender, _to, _value);
        
    }
    
    
}