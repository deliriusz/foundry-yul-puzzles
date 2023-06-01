/*
 *        __      __            __                                                __
 *       /  \    /  |          /  |                                              /  |
 *       $$  \  /$$/  __    __ $$ |        ______   __    __  ________  ________ $$ |  ______    _______
 *        $$  \/$$/  /  |  /  |$$ |       /      \ /  |  /  |/        |/        |$$ | /      \  /       |
 *         $$  $$/   $$ |  $$ |$$ |      /$$$$$$  |$$ |  $$ |$$$$$$$$/ $$$$$$$$/ $$ |/$$$$$$  |/$$$$$$$/
 *          $$$$/    $$ |  $$ |$$ |      $$ |  $$ |$$ |  $$ |  /  $$/    /  $$/  $$ |$$    $$ |$$      \
 *           $$ |    $$ \__$$ |$$ |      $$ |__$$ |$$ \__$$ | /$$$$/__  /$$$$/__ $$ |$$$$$$$$/  $$$$$$  |
 *           $$ |    $$    $$/ $$ |      $$    $$/ $$    $$/ /$$      |/$$      |$$ |$$       |/     $$/
 *           $$/      $$$$$$/  $$/       $$$$$$$/   $$$$$$/  $$$$$$$$/ $$$$$$$$/ $$/  $$$$$$$/ $$$$$$$/
 *                                       $$ |
 *                                       $$ |
 *                                       $$/
 *   
 *   
 *   NOTE: this code is meant to be easy to understand. In might not be most optimized.
 *   
 *   PLEASE, PLEASE, PLEASE, read this solution only after you try your best trying to solve the puzzle
 *   
 * */

object "Counter" {
  code {
    sstore(0x0, caller()) // store msg.sender

    // copy all runtime code to memory
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))

    // return code to be deployed
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {

      // no msg.value accepted here
      if gt(callvalue(), 0) {
        mstore(0x0, 0x1111) // put 0x1111 for test, this will revert with this value. Useful for debugging
        revert(0x0, 0x20)
      }

      let selector := shr(224, calldataload(0)) // get last 4 bytes (function selector) by shifting right

      // mask full value is 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff
      // that's because other bytes of this bytes32 variable are 0 padded. Remeber that EVM works on bytes32 only!
      // it's useful to zero out unnecessary bits using `and()` and `or()`
      let mask := 0xffffffffffffffffffffffffffffffffffffffff

      // Solidity contracts have very similar logic, i.e., take first 4 bytes (function selector),
      // do a switch statement, matching function signatures. When you find one, execute code inside
      switch selector
      case 0xe8927fbc { // increase()
        let slot0 := sload(0)

        // counter takes 96 upper bits. 160 bits are for address
        let counter := shr(160, slot0)

        // use mask to clear out bits over 160, because this bitwise `and` performs boolean logic on every bit of two values
        let owner := and(slot0, mask)

        let new_counter := add(counter, 1)

        // put if back together. Bitwise `or` performs boolean logic on every bit of two values.
        // that's why the dirty bits have to be cleared out first - to bitwise `or` them together
        // this is more-or-less what Solidity compiles to when using tightly packed slots
        let new_slot0 := or(shl(160, new_counter), owner)

        sstore(0, new_slot0)
      }

      case 0x9732187d { // decrease(uint64)
        if lt(calldatasize(), 0x24) {
           mstore(0x0, 0x2222)
           revert(0x0, 0x20)
        }

        let decrease_by := calldataload(4)

        if gt(decrease_by, 0x10000000000000000) { // 2**64
           mstore(0x0, 0x3333)
           revert(0x0, 0x20)
        }

        let slot0 := sload(0)
        let counter := shr(160, slot0)

        if gt(decrease_by, counter) {
           mstore(0x0, 0x4444)
           revert(0x0, 0x20)
        }

        let owner := and(slot0, mask)
        let new_counter := sub(counter, decrease_by)
        let new_slot0 := or(shl(160, new_counter), owner) // put it back together

        sstore(0, new_slot0)
      }

      case 0x61bc221a { // counter()
        let fmp := mload(0x40)
        let slot0 := sload(0)
        let counter := shr(160, and(slot0, not(mask)))

        mstore(fmp, counter)

        return (fmp, 0x20)
      }

      case 0x8da5cb5b { // owner()
        let fmp := mload(0x40)
        let slot0 := sload(0)
        let owner := and(slot0, mask)

        mstore(fmp, owner)

        return (fmp, 0x20)
      }

      default {
           mstore(0x0, 0x5555)
           revert(0x0, 0x20)
      }
    }
  }
}
