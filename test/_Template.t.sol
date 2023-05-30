// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "./lib/YulDeployer.sol";

interface _Template {}

contract _TemplateTest is Test {
    YulDeployer yulDeployer = new YulDeployer();

    _Template exampleContract;

    function setUp() public {
        exampleContract = _Template(yulDeployer.deployContract("_Template"));
    }

    function test_Template() public {
        bytes memory callDataBytes = abi.encodeWithSignature("randomBytes()");

        (bool success, bytes memory data) = address(exampleContract).call{gas: 100000, value: 0}(callDataBytes);

        assertTrue(success);
        assertEq(data, callDataBytes);
    }
}
