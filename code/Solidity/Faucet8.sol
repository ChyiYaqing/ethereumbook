// SPDX-License-Identifier: CC-BY-SA-4.0

// Version of Solidity compiler this program was written for
pragma solidity ^0.8.20;

contract Owned {
    address payable owner;

    // Contract constructor: set owner
    constructor() public {
        owner = payable(msg.sender);
    }

    // Access control modifier
    modifier onlyOwner {
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
    // 事件 用于记录任何提款
    event Withdrawal(address indexed to, uint amount);
    // 事件 用于记录任何存款
    event Deposit(address indexed from, uint amount);

    // Accept any incoming amount
    receive() external payable {
        // 使用emit 关键字将事件数据合并到事务日志中
        emit Deposit(msg.sender, msg.value);
    }

    // Give out ether to anyone who asks
    function withdraw(uint withdraw_amount) public {
        // Limit withdrawal amount
        require(withdraw_amount <= 0.1 ether);

        require(
            address(this).balance >= withdraw_amount,
            "Insufficient balance in faucet for withdrawal request"
        );

        // Convert msg.sender to an address payable
        address payable recipient = payable(msg.sender);

        // Send the amount to the address that requested it
        recipient.transfer(withdraw_amount);

        emit Withdrawal(msg.sender, withdraw_amount);
    }
}
