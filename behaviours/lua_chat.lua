--[[

 lua_chat.lua

 This behaviour allows users to 'chat' over a TCP connection in a manner
 similar to the UNIX 'talk' program.

 Copyright © Blu Wireless. All Rights Reserved.
 Licensed under the MIT license. See LICENSE file in the project.
 Feedback: james.pascoe@bluwireless.compiling

]]

local function main(args)

  print("Welcome to Lua Chat !")

  if (args) then
    Actions.Log.info("Arguments passed to Lua:")
    for k,v in pairs(args) do
      Actions.Log.info(string.format("  %s %s", tostring(k), tostring(v)))
    end
  end

  -- Validate and process the command-line arguments. The 'host' parameter
  -- specifies the host to connect to (and is mandatory). If the user wishes
  -- to run two instances of LuaChat on the same machine (e.g. for testing)
  -- then check that the 'port' and 'server_port' arguments are also present.
  if (not args or not args["host"]) then
    Actions.Log.fatal("destination hostname (or IP) must be specified " ..
                      "e.g. -a host=192.168.1.1")
  end

  if (args["host"] == "localhost" or args["host"] == "127.0.0.1") then
    if (not args["port"] or not args["server_port"]) then
      Actions.Log.fatal("destination port and server port must be provided " ..
                        "when running multiple instances of LuaChat on the " ..
                        "same host e.g. -a port=7777 -a server_port=8888")
    end
  end

end

local behaviour = {
  name = "LuaChat",
  description = "A Lua behaviour to allow users to chat over TCP",
  entry_point = main
}

return behaviour
