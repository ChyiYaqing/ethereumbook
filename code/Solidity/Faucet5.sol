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
        require(msg.sender == owner);
        _;
    }
}

// Solidity的合约对象支持继承,使用继承，使用关键字is指定父契约
// 通过继承，子合约继承了父合约的所有方法、功能和变量
// Solidity 支持多重继承，可以通过关键字后面以逗号分隔
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
