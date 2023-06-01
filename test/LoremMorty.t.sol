// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "./lib/YulDeployer.sol";

interface LoremMorty {}

contract LoremMortyTest is Test {
    YulDeployer yulDeployer = new YulDeployer();

    LoremMorty template;

    function setUp() public {
        template = LoremMorty(yulDeployer.deployContract("LoremMorty"));
    }

    function test_LoremMorty() public {
        (bool status, bytes memory data) = address(template).staticcall("");

        assertTrue(status);
        assertEq(data, bytes("You're growing up fast, Morty. You're going into a great big thorn straight into my ass. Nice one, Ms Pancakes. That guy is the Red Grin Grumbold of pretending he knows what's going on. Oh you agree huh? You like that Red Grin Grumbold reference? Well guess what, I made him up. You really are your father's children. Think for yourselves, don't be sheep. Meeseeks were not born into this world fumbling for meaning, Jerry!"));
    }
}
