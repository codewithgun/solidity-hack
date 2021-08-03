pragma solidity ^0.6.10;

contract DosVictim {
    address public highestBider;
    uint256 public highestBid;

    function bid() public payable {
        require(msg.value > highestBid);

        if (highestBider != address(0)) {
            (bool sent, ) = highestBider.call{value: highestBid}("");
            require(sent, "Send fail");
        }

        highestBider = msg.sender;
        highestBid = msg.value;
    }
}
