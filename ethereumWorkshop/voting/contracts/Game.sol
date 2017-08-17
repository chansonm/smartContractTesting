pragma solidity ^0.4.11;
// We have to specify what version of compiler this code will compile with

contract Game {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is candidate name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */
  mapping (bytes32 => uint8) public votesReceived;
  bytes32[] public candidateList;
  uint public blockNumber;
  bytes32 public blockHashNow;
  uint random_number;
  uint reward;
  uint reward2;

  // Constructor
  function Game(bytes32[] candidateNames) payable {
    candidateList = candidateNames;
  }



// This is the syntax for a default function that will be executed if ether is sent to the smart contract.
// If the smart contract should be able to receive ether, this function is mandatory. If it does not exist
// transactions containing ether will be sent back.
  function() payable {}

//  function playGame() payable returns (bool) {
//    reward = rouletteResult()*msg.value;
//    msg.sender.send(reward);
//    return true;
//  }

  function betOdd() payable returns (bool) {
    uint result = rouletteResult();
    if (result%2 == 1) {
      reward = 2*msg.value;
      msg.sender.send(reward);
      return true;
    } else {
      return false;
    }
  }

  function betEven() payable returns (bool) {
    uint result2 = rouletteResult();
    if (result2%2 == 0) {
//      reward2 = 2*msg.value;
//      msg.sender.send(reward2);
      return true;
    } else {
      return false;
    }
  }

//  function betEven() payable returns (bool) {
//    uint result2 = rouletteResult();
//    if (result2%2 == 0) {
//      reward2 = 2*msg.value;
//      msg.sender.send(reward2);
//      return true;
//    } else {
//      return false;
//    }
//  }
//
//  function betEven() payable returns (bool) {
//    uint result2 = rouletteResult();
//    uint reward2 = 2*msg.value;
//    if (result2%2 == 0) {
//      msg.sender.send(reward2);
//      return true;
//    } else {
//      return false;
//    }
//  }

  function rouletteResult() returns (uint) {
    blockNumber = block.number;
    blockHashNow = block.blockhash(blockNumber);
    random_number = uint(block.blockhash(block.number-1))%32;
    return random_number;
  }

// Interaction via truffle console:
// Game.deployed().then(function(contractInstance) {contractInstance.playGame.then(function(v) {console.log(v)})})
}