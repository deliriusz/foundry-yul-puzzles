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

object "LoremMorty" {
  code {

    // copy all runtime code to memory
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))

    // return code to be deployed
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {

      // load current free memory pointer
      let fmp := mload(0x40)

      // if free memory pointer is not initialized, set it to 0x60
      // this is a bit Solidity-ish, as in Yul you're free to use whichever memory slot you want
      // please note that Solidity uses 0x60 word as "0" slot, and 0x40 as free memory pointer
      // as a matter of showing how it works, I do memory expansion similar to how Solidity whould do it
      if iszero(fmp) {
         mstore(0x40, 0x60)
         fmp := 0x60
      }

      // increase free memory pointer to the size we need to allocate full LoremIpslumText
      mstore(0x40, add(fmp, datasize("LoremIpslumText")))

      // copy data to memory
      datacopy(fmp, dataoffset("LoremIpslumText"), datasize("LoremIpslumText"))

      // return Lorem Morty
      return(fmp, datasize("LoremIpslumText"))
    }

    data "LoremIpslumText" "You're growing up fast, Morty. You're going into a great big thorn straight into my ass. Nice one, Ms Pancakes. That guy is the Red Grin Grumbold of pretending he knows what's going on. Oh you agree huh? You like that Red Grin Grumbold reference? Well guess what, I made him up. You really are your father's children. Think for yourselves, don't be sheep. Meeseeks were not born into this world fumbling for meaning, Jerry!"
  }
}
