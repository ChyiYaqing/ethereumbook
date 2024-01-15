// SPDX-License-Identifier: CC-BY-SA-4.0

// Version of Solidity compiler this program was written for
// ^0.8.20表示允许使用0.8.20以上的任何较小修订版本进行编译
// Pragma指令不会编译为EVM字节码，它们仅编译器用来检查兼容性
pragma solidity ^0.8.20;

// Our first contract is a faucet!
contract Faucet {
    // Accept any incoming amount
    // payable() 后备/默认函数，如果触发合约的交易微命名合约中的任何已声明函数或根本没有任何函数
    // 则会调用该函数
    receive() external payable {}

    // Give out ether to anyone who asks
    function withdraw(uint withdraw_amount) public {
        // Limit withdrawal amount
        // 设置提款限额, require测试前提条件
        require(withdraw_amount <= 100000000000000000);

        // Convert msg.sender to an address payable
        address payable recipient = payable(msg.sender);

        // Send the amount to the address that requested it
        // msg代表触发合约执行的交易
        // sender: 是交易的发送着地址
        // transfer: 是一个内置函数，将以太币从当前合约转移到发送者的地址
        recipient.transfer(withdraw_amount);
    }
}
