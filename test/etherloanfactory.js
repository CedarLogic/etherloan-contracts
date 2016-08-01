contract('EtherLoanFactory', function(accounts) {
  it("should deploy with an emply EtherLoanRegistry", function(done) {
    var factory = EtherLoanFactory.deployed();
    var reg;

    factory.etherLoanRegistryAddress.call().then(function(address) {
      reg = EtherLoanRegistry.at(address);
      return reg.numLoans.call();
    }).then(function(numLoans){
      assert.equal(numLoans.valueOf(), 0, "should start with 0 loans");

    }).then(done).catch(done);
  });


  it("should allow to set a different EtherLoanRegistry", function(done) {
    var factory = EtherLoanFactory.deployed();
    var reg;
    var newAddr=accounts[0]; //this makes no sense, but I need any address to test

    factory.setEtherLoanRegistry(newAddr).then(function(address) {
      return factory.etherLoanRegistryAddress.call();
    }).then(function(address){
      assert.equal(newAddr, address, "should be the same address as setted");

    }).then(done).catch(done);
  });




});
