// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "./lib/YulDeployer.sol";

interface _Template {}

contract _TemplateTest is Test {
    YulDeployer yulDeployer = new YulDeployer();

    _Template template;

    function setUp() public {
        template = _Template(yulDeployer.deployContract("_Template"));
    }

    function test__Template() public {

    }
}
