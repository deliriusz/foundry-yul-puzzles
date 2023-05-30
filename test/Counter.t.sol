// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "./lib/YulDeployer.sol";

/// @dev this is the interface that the Counter has to implement
interface ICounter {
    function increase() external;
    function decrease(uint64 amount) external; // only owner can invoke it. Check for underflow conditions
    function counter() external returns (uint96); // counter and owner have to occupy single storage slot
    function owner() external returns (address); // this contract owner's address
}

contract CounterTest is Test {
    YulDeployer yulDeployer = new YulDeployer();

    ICounter counter;
    address secondOwner = address(0xdeadc0de);

    function setUp() public {
        counter = ICounter(yulDeployer.deployContract("Counter"));
    }

    function test_Counter_increase() public {
        counter.increase();

        bytes32 slot0 = vm.load(address(counter), 0x0);

        assertEq(counter.counter(), 1);
        // make sure you didn't mess up storage
        assertEq(slot0, bytes32(abi.encodePacked(uint96(1), address(msg.sender))));
    }

    function test_Counter_owner() public {
        assertEq(counter.owner(), msg.sender);

        vm.startPrank(secondOwner);
        ICounter newCounter = ICounter(yulDeployer.deployContract("Counter"));
        vm.stopPrank();

        assertEq(newCounter.owner(), secondOwner);
    }

    function test_Counter_decrease() public {
        for (uint i; i < 1000; i++) {
            counter.increase();
        }

        assertEq(counter.counter(), 1000);

        // expect revert, because this function accepts only 64 bits uint
        (bool status, bytes memory data) = address(counter).call(
            abi.encodeWithSignature("decrease(uint64)", type(uint96).max - 1)
        );

        assertEq(status, false);

        // expect revert, because value is bigger than current counter
        vm.expectRevert();
        counter.decrease(1001);

        counter.decrease(99);
        assertEq(counter.counter(), 901);

        counter.decrease(2);
        assertEq(counter.counter(), 899);

        bytes32 slot0 = vm.load(address(counter), 0x0);
        // make sure you didn't mess up storage
        assertEq(slot0, bytes32(abi.encodePacked(uint96(899), address(msg.sender))));

        counter.decrease(899);
        assertEq(counter.counter(), 0);
    }
}
