// SPDX-License-Identifier: CC-BY-SA-4.0

// Version of Solidity compiler this program was written for
pragma solidity ^0.8.20;

// Our first contract is a faucet!
contract Faucet {
    address payable owner;

    // Contract constructor: set owner
    constructor()  {
        owner = payable(msg.sender);
    }

    // Access control modifier
    // 要求存储合约所有者的地址与交易的msg.sender的地址相同
    // 这是访问控制的基本涉及模式，进允许合约的所有者执行任何具有onlyOwner修饰符的函数
    modifier onlyOwner {
        require(msg.sender == owner);
        // _; 占位符将替换为正在修改的函数的代码
        _;
    }

    // Accept any incoming amount
    receive() external payable {}

    // Contract destructor
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

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
