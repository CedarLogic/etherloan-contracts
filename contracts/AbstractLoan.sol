
contract AbstractLoan {

  /* borrower address */
  address public borrower;
  uint256 public amount;
  uint public state; /* 1: Funding, 2: Waiting for payment, 3: Finished, 0: Canceled */
  uint256 public rate; /* Suggested rate by the borrower */

  /* data structure to hold information about lenders */
  struct Lender {
    address addr;
    uint256 amount;
  }

  Lender[] public lenders;

  function AbstractLoan (address _borrower, uint256 _amount) {
      borrower = _borrower;
      amount = _amount;
      state = 1;
  }

  function cancelLoan(){
    /* Only the borrower can cancel. Cancel allowed only on funding stage */
    if(msg.sender == borrower && state == 1){
      /* Return funds to lenders */
      for (uint i = 0; i < lenders.length; ++i) {
        lenders[i].addr.send(lenders[i].amount);
      }
      state = 0;
    }
  }


  function lend(){
    /* Called by the lenders to lend some ETH */
    uint _amount = msg.value;
    lenders[lenders.length++] = Lender({addr: msg.sender, amount: _amount});
  }

  function accept(){
    /* Called by the borrower to accept the loan. Funds are transfered to the borrower. State = 2 */
    if(msg.sender == borrower){
      state = 2;
      borrower.send(amount);
    }
  }

  function pay(){
    /* called by the borrower to make the payment. Funds are transfered to the lenders */
    /* if all the loan has been paid, state = 3 */
    if(msg.sender == borrower){
      if(msg.value != amount) throw;

      for (uint i = 0; i < lenders.length; ++i) {
        lenders[i].addr.send(lenders[i].amount);
      }

      state = 3;
    }

  }



}
