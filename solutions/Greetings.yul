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

object "Greetings" {
  code {
    // storage layout
    function longGreetSlot() -> p { p:= 0 }

    // copy the longGreet string into storage
    sstore(longGreetSlot(), 0x3b) // store the hardcoded longGreet string length, and then below the string data
    sstore(add(longGreetSlot(), 1), 0x48656C6C6F2C20576F726C64212057656C636F6D65206F6E2074686973206A6F)
    sstore(add(longGreetSlot(), 2), 0x75726E657920746F206265636F6D6520612059756C2063686164210000000000)

    // copy all runtime code to memory
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))

    // return code to be deployed
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {

      let selector := shr(224, calldataload(0))

      switch selector
      case 0xcfae3217 /* greet() */ {
        let fmp := mload(0x40)

        let greet := "Hello, World!"
        let greetLength := 13

        // In solidity, a 13-bytes string takes 77-bytes space in memory. Here's why:
        //
        // store the location of the string in memory
        mstore(fmp, 0x20)

        // store the length of the string at its location
        mstore(add(fmp, 0x20), greetLength)

        // store the string data onwards
        mstore(add(fmp, 0x40), greet)

        // return the memory area where is stored the string
        return(fmp, add(0x40, greetLength))
      }

      case 0xce02571b /* longGreet() */ {
        let fmp := mload(0x40)
        let longGreetLength := sload(0)

        // The logic is the same for strings longer than 32-bytes
        //
        // store the location of the string in memory
        mstore(fmp, 0x20)

        // store the length of the string at the location
        mstore(add(fmp, 0x20), longGreetLength)

        // store the string data onwards
        for { let i := 1 } lt(i, 3) { i := add(i, 1) }
        {
            mstore(
                add(add(fmp,0x20), mul(0x20, i)),
                sload(i)
            )
        }
        
        // return the memory area where is stored the string
        return(fmp, add(0x40, longGreetLength))
      }
      
      default {
        revert(0,0)
      }
    }
  }
}
