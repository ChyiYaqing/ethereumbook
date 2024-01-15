// SPDX-License-Identifier: CC-BY-SA-4.0

// Version of Solidity compiler this program was written for
pragma solidity ^0.8.20;

// Our first contract is a faucet!
// 合约是一个包含数据和方法的容器
contract Faucet {
    address payable owner;

    // msg 对象是启动此合约执行的交易调用或消息调用
    // tx 对象提供了一种访问交易相关信息的方法
    // block 对象包含有关当前块的信息
    // address 对象

    // Contract constructor: set owner
    // 构造函数
    constructor() {
        owner = payable(msg.sender);
    }

    // Accept any incoming amount
    receive() external payable {}

    // Contract destructor
    function destroy() public {
        // 任何人从所有者以外的地址调用此销毁函数将失败.
        // 如果构造函数存储在所有者中的相同地址调用它，则合约将自毁并将任何剩余金额发送到所有者地址
        require(msg.sender == owner);
        // 合约销毁函数
        selfdestruct(owner);
    }

    // Give out ether to anyone who asks
    // uint == uint256
    // public, private, internal, external 指定函数的可见性
    function withdraw(uint withdraw_amount) public {
        // Limit withdrawal amount
        require(withdraw_amount <= 0.1 ether);

        // Convert msg.sender to an address payable
        address payable recipient = payable(msg.sender);

        // Send the amount to the address that requested it
        recipient.transfer(withdraw_amount);
    }
}
