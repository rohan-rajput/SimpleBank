//SPDX-License-Identifier: MIT
// Bank Contract to deposit withdraw and check balance
pragma solidity ^0.8.0;

contract bank{
    mapping (address=>uint) private balances;
    address owner;

    event LogDepositMade(address accountAddress,uint amount);

    constructor(){
        owner  = msg.sender;
    }

    function deposit() public payable returns(uint) {
         // Use 'require' to test user inputs, 'assert' for internal invariants
        // Here we are making sure that there isn't an overflow issue
        require((balances[msg.sender]+msg.value)>=balances[msg.sender]);
        balances[msg.sender]+=msg.value;
        emit LogDepositMade(msg.sender,msg.value);
        return msg.value;
    } 

     function withdraw(uint withdrawAmount) public returns (uint remainingBalance) {
         require(withdrawAmount<=balances[msg.sender]);
         balances[msg.sender] -=withdrawAmount;
         payable(msg.sender).transfer(withdrawAmount);
         return balances[msg.sender];
     }

    function balance()view public returns(uint) {
        return balances[msg.sender];
    }

}
