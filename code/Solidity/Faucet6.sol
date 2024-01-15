// SPDX-License-Identifier: CC-BY-SA-4.0

// Version of Solidity compiler this program was written for
pragma solidity ^0.8.20;

// Solidity中错误处理由四个函数处理
// assert, require, revert, throw
// assert和require函数评估条件并在条件为false是停止执行并显示错误

contract Owned {
    address payable owner;

    // Contract constructor: set owner
    constructor() public {
        owner = payable(msg.sender);
    }

    // Access control modifier
    modifier onlyOwner {
        // require可以包含一条有用的文本消息,用于显示错误的原因
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
}

contract Mortal is Owned {
    // Contract destructor
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }
}

contract Faucet is Mortal {
    // Accept any incoming amount
    receive() external payable {}

    // Give out ether to anyone who asks
    function withdraw(uint withdraw_amount) public {
        // Limit withdrawal amount
        require(withdraw_amount <= 0.1 ether);

        // Convert msg.sender to an address payable
        address payable recipient = payable(msg.sender);

        // Send the amount to the address that requested it
        recipient.transfer(withdraw_amount);
    }
}
