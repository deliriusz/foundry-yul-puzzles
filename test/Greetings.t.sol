// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "./lib/YulDeployer.sol";

interface IGreetings {
    function greet() external returns (string memory); // should return 'Hello, World!'
    function longGreet() external returns (string memory); // should return the string stored in contract storage
}

contract GreetingsTest is Test {
    YulDeployer yulDeployer = new YulDeployer();

    IGreetings greetings;

    function setUp() public {
        greetings = IGreetings(yulDeployer.deployContract("Greetings"));
    }

    function test_Greetings() public {
        assertEq(greetings.greet(), "Hello, World!");
        assertEq(
            greetings.longGreet(),
            "Hello, World! Welcome on this journey to become a Yul chad!"
        );
    }
}
