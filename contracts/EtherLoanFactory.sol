import "SimpleLoan.sol";
import "EtherLoanRegistry.sol";

contract EtherLoanFactory {

  address public etherLoanRegistryAddress;

  function EtherLoanFactory(){
    etherLoanRegistryAddress = new EtherLoanRegistry();
  }

  function createSimpleLoan ( uint256 _amount, bytes _ipfsHash) {
      address newLoan = new SimpleLoan(msg.sender,_amount,_ipfsHash);
      //Store the address of the new loan on EtherLoanRegistry;
      EtherLoanRegistry(etherLoanRegistryAddress).addLoan(newLoan);
  }


  //Future-proofness functions
  function setEtherLoanRegistry(address newRegistryAddr){
    etherLoanRegistryAddress = newRegistryAddr;
  }

}
