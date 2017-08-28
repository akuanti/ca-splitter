pragma solidity ^0.4.4;


contract Splitter {
	address recipient1;
	address recipient2;

	function Splitter(address _recipient1, address _recipient2) {
		recipient1 = _recipient1;
		recipient2 = _recipient2;
	}

	function split() payable
		returns (bool) {
		uint splitAmount = msg.value / 2;

		recipient1.transfer(splitAmount);
		recipient2.transfer(splitAmount);
		return true;
	}

	function getRecipients() constant returns(address, address) {
		return (recipient1, recipient2);
	}
}
