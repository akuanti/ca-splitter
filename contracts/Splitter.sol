pragma solidity ^0.4.4;

import "./Owned.sol";

contract Splitter is Owned {
    // keep track of each recipient and balance
    mapping (address => uint) public balances;

    event LogDeposit(address sender, address recipient1, address recipient2, uint amount);
    event LogDepositChange(address sender, uint amount);
    event LogWithdrawal(address recipient, uint amount);

    function Splitter() {}

    function() {}

    function split(address recipient1, address recipient2) public payable
        returns (bool)
    {
        require(recipient1 != 0);
        require(recipient2 != 0);

        uint splitAmount = msg.value / 2;

        balances[recipient1] += splitAmount;
        balances[recipient2] += splitAmount;
        LogDeposit(msg.sender, recipient1, recipient2, splitAmount);

        // credit remainder to the sender
        uint remainder = msg.value % 2;
        balances[msg.sender] += remainder;
        LogDepositChange(msg.sender, remainder);

        return true;
    }

    function withdraw() public {
        uint amount = balances[msg.sender];
        require(amount > 0);

        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
        LogWithdrawal(msg.sender, amount);
    }
}
