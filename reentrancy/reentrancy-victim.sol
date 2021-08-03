pragma solidity ^0.6.10;

contract Victim {
    mapping(address => uint) public balances;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "insufficient");
        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Fail to send");
        balances[msg.sender] -= _amount;
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}