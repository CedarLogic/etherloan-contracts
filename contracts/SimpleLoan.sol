import "AbstractLoan.sol";

contract SimpleLoan is AbstractLoan{

  bytes public description;

  function SimpleLoan (address _borrower, uint256 _amount, bytes _ipfsHash) AbstractLoan(_borrower,_amount){
    description = _ipfsHash;
  }

  /* One payment loan */
  /* Due date */
  /* Payment should be exactly the amount lended. amount+interest */

  

}
