var bank = "0xef17ec5df3116dea3b7abaf1ff3045639453cc76";
var buyer = "0x35ddac855e0029676f489dafca9ab405a348317c";
var dealer = "0x46bf8994c8702919434271d89bcad8abec915612";
var dmv = "0x518a6377a3863201aef3310da41f3448d959a310";

var vin = 1234567890
var cost = 4000000000000000000
var fees = 1000000000000000000
var gas = 1000000;
var total = 5000000000000000000

function showBalances() {
  var i = 0;
  eth.accounts.forEach(function(e) {
     console.log("---> eth.accounts["+i+"]: " + e + " \tbalance: " + web3.fromWei(eth.getBalance(e), "ether") + " ether");
     i++;
  })
};
