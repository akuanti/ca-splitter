pragma solidity ^0.4.4;


contract Splitter {
	address owner;

	// keep track of each recipient and balance
	mapping (address => uint) public balances;

	event LogSplit(address recipient1, address recipient2, uint amount);
	event LogWithdrawal(address recipient, uint amount);

	function Splitter() {
		owner = msg.sender;
	}

	function () {}

	function split(address recipient1, address recipient2) public payable
		returns (bool)
	{
		if (recipient1 == 0) throw;
		if (recipient2 == 0) throw;

		uint splitAmount = msg.value / 2;

		balances[recipient1] += splitAmount;
		balances[recipient2] += splitAmount;
		LogSplit(recipient1, recipient2, splitAmount);

		return true;
	}

	function withdraw() public {
		uint amount = balances[msg.sender];
		if (amount == 0) throw;

		balances[msg.sender] = 0;
		msg.sender.transfer(amount);
		LogWithdrawal(msg.sender, amount);
	}

	function kill() {
		if (msg.sender == owner) {
			suicide(owner);
		}
	}
}
