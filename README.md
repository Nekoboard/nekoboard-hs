nekoboard-hs
============

A custom keyboard firmware written for Arduino in Haskell [Copilot].

[Copilot]: https://github.com/leepike/Copilot

## Usage
 
The bridge between Haskell and C lies in [`copilot-spec.hs`]. Read [Copilot documentation][1] and add your high-level firmware logic starting from that file. Basically, it operates on `streams` of data (somewhat similar to lazy lists), which arrive discretely each time the Copilot `step()` function is called. One can compose streams, e.g. take two streams and produce a stream of sums of the two streams at each time step.  Then a *spec* is written which assigns *triggers* to `Stream Bool`s.
 
The C part is in [`sketch.cpp`][]. Ideally, this contains only primitive IO and the absolute minimum of reliable (i.e. well-tested) code. The Haskell side can access any exported (i.e. non-static) symbol: function, global variable, global array. You also have to provide *triggers* on the C side: functions which will be called whenever certain clause of the Copilot spec is violated. They are handling the *output* of your firmware computation, and ideally they're small, simple and focused.

Thanks to the [`Makefile`] the Copilot code is compiled and executed to generate `copilot-c99-codegen/copilot.{c,h}` just when they are needed to be compiled and linked against the `sketch.o` to produce the final firmware. The firmware can be uploaded simply via [`make upload`](https://github.com/sudar/Arduino-Makefile/blob/master/Arduino.mk#L131).
 
[`copilot-spec.hs`]: copilot-spec.hs
[`sketch.cpp`]: sketch.cpp
[`Makefile`]: Makefile
[1]: https://github.com/niswegmann/copilot-discussion

## Dependencies

 * [Arduino], the software. Probably you'll want to test this on a real hardware board too. I used a SparkfunFun ProMicro 3.3V, so in Makefile you see the path to [alternative Arduino core][SF32u4_boards] from Sparkfun. That is also the reason of old `arduino-1.0.5` installed locally.
 
  Off course you can adapt the arduino part or even get rid of it altogether. Forks welcome.
 
  Edit Makefile and set the path to Arduino in `ARDUINO_DIR`.

 * [`arduino-mk`][arduino-mk]. In Ubuntu:

        $ sudo apt-get install arduino-mk
     
    Edit Makefile and set the path to it in `ARDMK_DIR` (matches default for Ubuntu).
 
 * Also tune `MONITOR_PORT` to point at your device's serial.
 
 * Haskell. I hope you already know something about it; if not, http://learnyouahaskell.com/ — this is a great tutorial.

   In Ubuntu:
   
        $ sudo apt-get install haskell-platform
        
 * Check that have the most recent [Cabal]:
 
        $ sudo apt-get install cabal-install
        $ cabal update
        $ cabal install cabal-install
        $ cabal update
       
 * Install [Copilot]:
 
        $ cabal install copilot
       
 * This code also assumes that you have `make`.

[arduino]: http://arduino.cc/
[arduino-mk]: https://github.com/sudar/Arduino-Makefile
[SF32u4_boards]: https://github.com/sparkfun/SF32u4_boards
[Cabal]: http://www.haskell.org/cabal/
