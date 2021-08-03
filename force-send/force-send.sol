pragma solidity ^0.6.10;

contract ForceSend {
    //For send token to non-payable contract
    function send(address payable _to) public payable {
        selfdestruct(_to);
    }
}
