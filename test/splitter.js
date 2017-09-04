var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter', function(accounts) {
  var owner = accounts[0];
  var alice = owner;
  var bob = accounts[1];
  var carol = accounts[2];
  var splitter;

  beforeEach(function() {
    return Splitter.new({from: alice})
      .then(_splitter => {
        splitter = _splitter;
      });
  });

  it("should send half to Bob and half to Carol", function() {
    var sendAmount = 10;
    var bobBalance;
    var carolBalance;

    // console.log(bobBalance.toString(10), carolBalance.toString(10));

    return splitter.split(bob, carol, {from: alice, value: sendAmount})
      .then(txObject => {
        // console.log(txObject);

        return splitter.balances(bob);
      })
      .then(_balance  => {
        bobBalance = _balance;
        return splitter.balances(carol);
      })
      .then(_balance => {
        carolBalance = _balance;
        var splitAmount = sendAmount / 2;

        // balances in the contract should be updated
        assert.strictEqual(bobBalance.toString(10), String(splitAmount), "Bob has the wrong balance.");
        assert.strictEqual(carolBalance.toString(10), String(splitAmount), "Carol has the wrong balance.");
      });
  });

  it("should credit the sender with the leftovers", function() {
    var sendAmount = 11;

    return splitter.split(bob, carol, {from: alice, value: sendAmount})
      .then(txObject => {
        return splitter.balances(alice);
      })
      .then(_balance => {
        assert.strictEqual(_balance.toNumber(), 1);
      });
  });
});
