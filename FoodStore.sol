pragma solidity ^0.5.1;

contract FoodStore {
    
    struct Ordersdata{
        string name;
        uint timestamp;
        address addr;
    }
    
  //mapping (bytes32 => bool) private listOrder;
  mapping (uint => Ordersdata) private listOrder;
  mapping (uint => string) private listCustommer;
  mapping (uint => uint) private listTimestamp;
  mapping (uint => address) private listAddress;

  //---events---
  event OrderAdded(
    address from,   
    string text,
    uint datetime,
    bytes32 hash
  );
  
  event OrderError(
    address from,
    string text,
    string reason
  );

  uint orderCount = 0;

  // store the proof for a student in the contract state

  function recordNameOrder(string memory name) private {
    listCustommer[orderCount] = name;
  }

  function recordTimestampOrder(uint date) private {
    listTimestamp[orderCount] = date;
  }

  function recordAddressOrder(address addr) private{
    listAddress[orderCount] = addr;
  }
  
  function recordOrder(Ordersdata memory data_order) private{
      listOrder[orderCount] = data_order;
  }
  
  function GetOrder(string memory name) public payable {
      
    //Fried rice
    if (msg.value != 0.0035 ether && hashing(name) == hashing("Fried rice")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.0035 ether for registration");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
    //Congee 
    if (msg.value != 0.0040 ether && hashing(name) == hashing("Congee")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.0040 ether for registration");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
    //Wonton soup
    if (msg.value != 0.0045 ether && hashing(name) == hashing("Wonton soup")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.0045 ether for registration");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
    //Latte
    if (msg.value != 0.0025 ether && hashing(name) == hashing("Latte")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.0025 ether for registration");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
     //Grape juice
    if (msg.value != 0.0020 ether && hashing(name) == hashing("Grape juice")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.0020 ether for registration");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }
    
     //Lemonade
    if (msg.value != 0.0028 ether && hashing(name) == hashing("Lemonade")) {
        
        emit OrderError(msg.sender, name, 
            "Incorrect amount of Ether. 0.0028 ether for registration");
        
        
        msg.sender.transfer(msg.value);
        
        return;
    }

   
    Ordersdata memory orderdata = Ordersdata(name, block.timestamp, msg.sender);
    recordOrder(orderdata);
    recordNameOrder(name);
    recordTimestampOrder(now);
    recordAddressOrder(msg.sender);
    orderCount++;

    
    //---fire the event---
   emit OrderAdded(msg.sender, name, now,
        hashingOrder(name, now, msg.sender));
    }
  
  // SHA256 for Integrity
  
  function hashing(string memory name) private 
  pure returns (bytes32) {
    return sha256(bytes(name));
  }

  function hashingOrder(string memory name, uint timestamp, address addr) private
  pure returns (bytes32) {
    return sha256(abi.encodePacked(name,timestamp,addr));
  }
  
  // get name
  function getName(uint index) public view returns (string memory) {
    return listCustommer[index];
  }

  // get timestamp
  function getTimestamp(uint index) public view returns (uint) {
    return listTimestamp[index];
  }
  
  // get address
  function getAddress(uint index) public view returns (address) {
    return listAddress[index];
  }
  
  //get countorder
  function getOrderCount() public view returns (uint){
    return orderCount;
  }
}