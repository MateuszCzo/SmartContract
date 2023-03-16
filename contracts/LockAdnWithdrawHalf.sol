// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract LockAndWithdrawHalf {

    address payable public owner;
    uint public unlockTime;

    event Withdraw(uint amount, uint wher);

    constructor(uint _unlockTime) payable {
        require(_unlockTime > block.timestamp, "Unlock time time has to be in the future.");

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdrawHalf() public {
        require(msg.sender == owner, "Only the smart contract owner can withdraw founds.");
        require(block.timestamp > unlockTime, "Founds are not available yet, please wait longer.");

        emit Withdraw(address(this).balance / 2, block.timestamp);
        owner.transfer(address(this).balance / 2);
    }
}