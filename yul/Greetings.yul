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
 *
 *      ___  ___  _______   ___       ___       ________                ___       __   ________  ________  ___       ________  ___       
 *     |\  \|\  \|\  ___ \ |\  \     |\  \     |\   __  \              |\  \     |\  \|\   __  \|\   __  \|\  \     |\   ___ \|\  \      
 *     \ \  \\\  \ \   __/|\ \  \    \ \  \    \ \  \|\  \             \ \  \    \ \  \ \  \|\  \ \  \|\  \ \  \    \ \  \_|\ \ \  \     
 *      \ \   __  \ \  \_|/_\ \  \    \ \  \    \ \  \\\  \  ___        \ \  \  __\ \  \ \  \\\  \ \   _  _\ \  \    \ \  \ \\ \ \  \    
 *       \ \  \ \  \ \  \_|\ \ \  \____\ \  \____\ \  \\\  \|\  \        \ \  \|\__\_\  \ \  \\\  \ \  \\  \\ \  \____\ \  \_\\ \ \__\   
 *        \ \__\ \__\ \_______\ \_______\ \_______\ \_______\ \  \        \ \____________\ \_______\ \__\\ _\\ \_______\ \_______\|__|   
 *         \|__|\|__|\|_______|\|_______|\|_______|\|_______|\/  /|        \|____________|\|_______|\|__|\|__|\|_______|\|_______|   ___ 
 *                                                         |\___/ /                                                                 |\__\
 *                                                         \|___|/                                                                  \|__|
 *      
 *
 *   .--------------------------------------------------------------------------------------------------------------------.
 *   | All new encounters start with a hello.  Our new friend Yul will be no exception to the rule. Let's Meet and Greet! |
 *   '--------------------------------------------------------------------------------------------------------------------'
 *                                                                                                                                 
 *   
 *   * The code has to conform to the following interface (and comments):
 *   ```
 *     interface IGreetings {
 *         function greet() external returns (string memory); // should return 'Hello, World!'
 *         function longGreet() external returns (string memory); // should return the string stored in contract storage
 *     }
 *   ```
 *   
 *   * If you want to check if your code works as expected, look at the test cases in test/Greetings.
 *   
 *   * To run this beautiful guy, execute:
 *   forge test -vvv --match-test 'Greetings'
 *   */

object "Greetings" {
  code {
    // YOUR CUSTOM CONSTRUCTOR LOGIC GOES HERE

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
      // YOUR CODE GOES HERE
      // You might want to know how strings should be encoded: https://docs.soliditylang.org/en/v0.8.21/abi-spec.html#design-criteria-for-the-encoding
    }
  }
}
