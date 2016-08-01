import "SimpleLoan.sol";
import "EtherLoanRegistry.sol";

contract EtherLoanFactory {
  event LoanCreated(string _type, address _loanAddress, uint _timestamp);

  address public etherLoanRegistryAddress;

  function EtherLoanFactory(){
    etherLoanRegistryAddress = new EtherLoanRegistry();
  }

  function createSimpleLoan ( uint256 _amount, bytes _ipfsHash) {
      address newLoanAddress = new SimpleLoan(msg.sender,_amount,_ipfsHash);

      LoanCreated("simpleLoan", newLoanAddress, now);

      //Store the address of the new loan on EtherLoanRegistry;
      EtherLoanRegistry registry=EtherLoanRegistry(etherLoanRegistryAddress);
      registry.addLoan(newLoanAddress);
  }


  //Future-proofness functions
  function setEtherLoanRegistry(address newRegistryAddr){
    etherLoanRegistryAddress = newRegistryAddr;
  }

}
