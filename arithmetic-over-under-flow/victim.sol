pragma solidity ^0.6.10;

contract Timelock {
    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;
    
    function deposit() external payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = now + 1 weeks;
    }
    
    function increaseLockTime(uint _secondsToIncrease) public {
        lockTime[msg.sender] += _secondsToIncrease;
    }
    
    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient fund");
        require(lockTime[msg.sender] <= now, "Locked");
        
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}