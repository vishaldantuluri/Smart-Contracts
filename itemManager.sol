// SPDX-License-Identifier: RANDOM_TEXT

pragma solidity ^0.8.1;

contract ItemManager {

    enum supplyChain{Created, Paid, Delivered}
    
    struct Item{
        ItemManager.supplyChain Step;
        string identifier;
        uint itemprice;
    }
    
    event step(uint itemIndex, uint chainStep);
    
    
    uint public index;
    mapping(uint => Item) public items;
    
    function createItem(string memory _identifier, uint _price) public {
        
        items[index].identifier = _identifier;
        items[index].itemprice = _price;
        items[index].Step = supplyChain.Created;
        emit step(index, uint(items[index].Step));
        index ++;
        
    }
    
    function triggerPayment(uint _index) public payable{
        
        require(items[_index].Step == supplyChain.Created, 'This step has been processed');
        require(msg.value >= items[_index].itemprice, 'Full amount has to be paid');
        items[_index].Step = supplyChain.Paid;
        emit step(_index, uint(items[_index].Step));
    }
    
    function triggerDelivery(uint _index) public{
        
        require(items[_index].Step == supplyChain.Paid, 'This step has been processed');
        items[_index].Step = supplyChain.Delivered;
        emit step(_index, uint(items[_index].Step));
        
    }
}