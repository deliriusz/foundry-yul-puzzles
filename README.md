# About
This is a repo containing Yul puzzles to improve your Yul skills. Shoutdout to CodeForce, who created this template.

## Repository installation

1. Install Foundry
```
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

2. Install solidity compiler
https://docs.soliditylang.org/en/latest/installing-solidity.html#installing-the-solidity-compiler

3. Build Yul contracts and check tests pass
```
forge test
```

## Running tests

Run tests (compiles yul then fetch resulting bytecode in test)
```
forge test
```

To see the console logs during tests
```
forge test -vvv
```

## Contributing
Feel free to create new puzzles and create pull request to merge it. To create a puzzle:
1. copy `yul/_Template.yul`, rename it and provide puzzle description
2. copy `test_Template.t.yul`, rename it and provide all test cases verifying correctness of the solution
3. write solution to the puzzle to `solutions` folder