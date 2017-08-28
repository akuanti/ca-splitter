var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter', function(accounts) {
  var owner = accounts[0];
  var alice = owner;
  var bob = accounts[1];
  var carol = accounts[2];
  var splitter;

  beforeEach(function() {
    return Splitter.new(bob, carol, {from: alice})
      .then(_splitter => {
        splitter = _splitter;
      });
  });

  it("should send half to Bob and half to Carol", function() {
    var sendAmount = 10;
    var bobBalance = web3.eth.getBalance(bob);
    var carolBalance = web3.eth.getBalance(carol);

    // console.log(bobBalance.toString(10), carolBalance.toString(10));

    return splitter.split({from: alice, value: sendAmount})
      .then(txObject => {
        // console.log(txObject);

        var splitAmount = sendAmount / 2;
        assert.strictEqual(web3.eth.getBalance(bob).toString(10),
          bobBalance.add(splitAmount).toString(10),
          "Bob has the wrong balance");
        assert.strictEqual(web3.eth.getBalance(carol).toString(10),
          carolBalance.add(splitAmount).toString(10),
          "Carol has the wrong balance");
      });
  });

});
