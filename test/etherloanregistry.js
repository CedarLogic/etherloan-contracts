contract('EtherLoanRegistry', function(accounts) {
  it("should deploy with an empty EtherLoanRegistry", function(done) {
    var reg;

    EtherLoanRegistry.new()
    .then(function(regContract){
      reg=regContract;
      return reg.numLoans.call();
    }).then(function(numLoans){
      assert.equal(numLoans.valueOf(), 0, "should start with 0 loans");
    }).then(done).catch(done);
  });

  it("should add a loan", function(done) {
    var reg;
    var loanAddr=accounts[0]; //Makes no sense, but I need and address

    EtherLoanRegistry.new()
    .then(function(regContract){
      reg=regContract;
      return reg.addLoan(loanAddr);
    }).then(function(tx){
      return reg.numLoans.call();

    }).then(function(numLoans){
      assert.equal(numLoans.valueOf(), 1, "should increase the length of the loans array");
      return reg.getLoan.call(0);
    }).then(function(loanAddress){
      assert.equal(loanAddress, loanAddr, "should store the address correctly");

    }).then(done).catch(done);
  });


});
