contract EtherLoanRegistry {

  address[] public loans;

  function addLoan (address loanAddress) {
      loans.push(loanAddress);
  }

  function getLoan (uint i) returns (address) {
      return loans[i];
  }

  function numLoans() returns (uint){
    return loans.length;
  }

}
