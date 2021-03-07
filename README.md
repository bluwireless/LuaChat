<p align="center">
  <a href="http://lua.org">
    <img src="third_party/lua.org/lua-chat-logo.png" width=200>
  </a>
</p>

# LuaChat

A Unix 'talk' application implemented using C++17 and Lua 5.3/5.4. [![Build Status](
https://travis-ci.org/bluwireless/LuaChat.svg?branch=master)](
https://travis-ci.org/bluwireless/LuaChat)

LuaChat is an example of how to combine modern C++ and Lua 5.3/5.4. In particular, LuaChat
implements a library of C++ primitives called *actions*. The actions library is
wrapped using the 'Simplified Wrapper and Interface Generator' ([SWIG](http://swig.org))
to create a Lua binding. This binding is imported into files of Lua that combine
sequences of actions with other Lua code to implement *behaviours*.

LuaChat includes the following third-party libraries:

1. [Asio](https://think-async.com/Asio/) - TCP communication and timers
2. [spdlog](https://github.com/gabime/spdlog) - fast logging from both C++ and Lua
3. [cxxopts](https://github.com/jarro2783/cxxopts) - C++ command-line argument processing
4. [pmm](https://github.com/vector-of-bool/pmm) - CMake package manager manager

## Install

LuaChat has been built and tested on Linux Mint 19 and MacOS X (Catalina/Big Sur). Note
that your compiler must implement C++17 (or greater) and the filesystem module must
be available in the std::filesystem namespace. Compilers that are known to work
include gcc 8, clang 9 and Apple clang 12.

LuaChat requires Lua 5.3/5.4, LuaRocks and SWIG to be installed. In addition, LuaChat
requires the Lua POSIX wrapper to be installed. For Linux Mint 19, this can be achieved with:

```bash
sudo apt-get -y install lua5.3 lua5.3-dev luarocks swig
sudo luarocks install luaposix
```

If you would like to use Lua 5.4 and are running Ubuntu 20.10 (i.e. Groovy) or later, then you can
simply substitute 5.4 for 5.3 into the above i.e. there are packages available. For other operating
systems, you may need to build Lua 5.4 from source. It is straightforward and there are good instructions
on the [Lua.org](https://www.lua.org/download.html) website.

For MacOS use:

```bash
brew install lua luarocks swig
luarocks install luaposix
```

Then, for both platforms, clone and build the code with:

```bash
git clone https://github.com/bluwireless/LuaChat.git
mkdir build; cd build; cmake ../LuaChat; make
./src/lua_chat
```

This should build LuaChat and print its usage information.

## Usage

Running the LuaChat executable will print a usage message similar to the following:

```
Please specify a Lua behaviour to run!
Lua Chat - An Example of Integrating C++17 and Lua 5.3/5.4
Usage:
  ./src/lua_chat [OPTION...] [Lua behaviour to run]

  -a, --args arg  Arguments passed to all Lua behaviours. Expressed in
                  'key=value' form and can be used multiple times
  -h, --help      Print help and exit

 Logging options:
  -f, --filename arg        Log filename (default: logs/lua-chat.log)
  -l, --level arg           Console logging level: off, trace, debug, info,
                            warning, error and critical (default: warning)
      --log-file-level arg  Log file logging level: off, trace, debug, info,
                            warning, error and critical (default: info)
```

LuaChat requires a minimum of two parameters to run:

1. the path to the Lua behaviour file i.e. ```<path to repo>/behaviours/lua_chat.lua```
2. the name of the remote host to connect to e.g. ```-a host=remote_machine_b```

A typical LuaChat session would be started with:

```
./src/lua_chat -a host=<remote host-name or IP address> <path to repo>/behaviours/lua_chat.lua
```

with a corresponding session running in the opposite direction.

It is also possible to run two instances of LuaChat on the same host. In order to do so,
the 'port' and 'server_port' parameters must also be specified. E.g.:

```
./src/lua_chat -a host=localhost -a port=6666 -a server_port=7777 <path to repo>/behaviours/lua_chat.lua
```

and then in another window:

```
./src/lua_chat -a host=localhost -a port=7777 -a server_port=6666 <path to repo>/behaviours/lua_chat.lua
```

## Support

Please email james@james-pascoe.com for support.
