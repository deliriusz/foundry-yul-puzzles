/*
     __      __            __                                                __
    /  \    /  |          /  |                                              /  |
    $$  \  /$$/  __    __ $$ |        ______   __    __  ________  ________ $$ |  ______    _______
     $$  \/$$/  /  |  /  |$$ |       /      \ /  |  /  |/        |/        |$$ | /      \  /       |
      $$  $$/   $$ |  $$ |$$ |      /$$$$$$  |$$ |  $$ |$$$$$$$$/ $$$$$$$$/ $$ |/$$$$$$  |/$$$$$$$/
       $$$$/    $$ |  $$ |$$ |      $$ |  $$ |$$ |  $$ |  /  $$/    /  $$/  $$ |$$    $$ |$$      \
        $$ |    $$ \__$$ |$$ |      $$ |__$$ |$$ \__$$ | /$$$$/__  /$$$$/__ $$ |$$$$$$$$/  $$$$$$  |
        $$ |    $$    $$/ $$ |      $$    $$/ $$    $$/ /$$      |/$$      |$$ |$$       |/     $$/
        $$/      $$$$$$/  $$/       $$$$$$$/   $$$$$$/  $$$$$$$$/ $$$$$$$$/ $$/  $$$$$$$/ $$$$$$$/
                                    $$ |
                                    $$ |
                                    $$/


       *    Ho Ho Ho MFs! Santa Clause is comin' to town y'all crazy people! And he's lookin' for some
      ***    naughty folks to have a party with. Santa is bullish on crypto, so he decides to put party
     *****    counter on-chain. But, because he's a busy guy, you have to help him and write required smart
    *******    contract. Remember, all naughty people use Yul, so you should better use the same. GLHF!
   *********
  ***********
 *************
***************
      |||
      |||

* The code has to conform to the following interface (and comments):
```
  interface ICounter {
      function increase() external;
      function decrease(uint64 amount) external; // only owner can invoke it. Check for underflow conditions
      function counter() external returns (uint96); // counter and owner have to occupy single storage slot
      function owner() external returns (address); // this contract owner's address
  }
```

* Because Santa is a cheapskate, he wants you to put owner and counter in one storage slot:
      96 bits counter                   160 bits addres
|------------------------|----------------------------------------|

* If you want to check if your code works as expected, look at the test cases in test/Counter.

* To run this beautiful guy, execute:
forge test -vvv --match-test 'Counter'
*/

object "Counter" {
  code {
    // YOUR CUSTOM CONSTRUCTOR LOGIC GOES HERE

    // copy all runtime code to memory
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))

    // return code to be deployed
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {
      // YOUR CODE GOES HERE

    }
  }
}
