pragma solidity ^0.4.4;

contract Owned {
    address public owner;

    function Owner() {
        owner = msg.sender;
    }

    function kill() {
        if (msg.sender == owner) {
            selfdestruct(owner);
        }
    }
}
