--[[

 lua_chat.lua

 This behaviour allows users to 'chat' over a TCP connection in a manner
 similar to the UNIX 'talk' program.

 Copyright © Blu Wireless. All Rights Reserved.
 Licensed under the MIT license. See LICENSE file in the project.
 Feedback: james.pascoe@bluwireless.compiling

]]

function sender (talk, host, port)

  while true do

    local ret = require 'posix'.rpoll(0, 1000)
    if (ret == 1) then
      local message = io.read()
      if (message ~= "") then

        local ret = talk:Send(
          tostring(host), tostring(port), tostring(message)
        )

        if (ret == Actions.Talk.ErrorType_SUCCESS) then
          Actions.Log.info(
            string.format(
              "Message sent to %s:%s %s", host, port, message
            )
          )
        end
      end
    end

    coroutine.yield()

  end

end

function receiver (talk, host, port)

  while true do

    -- Yield until a message arrives, at which point, print it
    repeat
      coroutine.yield()
    until talk:IsMessageAvailable()

    message = talk:GetNextMessage()

    Actions.Log.info(
      string.format(
        "Received from %s:%s %s", host, port, message
      )
    )

    print(host .. ":" .. tostring(port) .. "> " .. message)

  end

end

-- Coroutine dispatcher (see Section 9.4 of 'Programming in Lua')
function dispatcher (coroutines)

  local timer = Actions.Timer()

  while true do
    if next(coroutines) == nil then break end -- no more coroutines to run

    for name, co in pairs(coroutines) do
      local status, res = coroutine.resume(co)

      if res then -- coroutine has returned a result (i.e. finished)

        if type(res) == "string" then  -- runtime error
          Actions.Log.critical("Lua coroutine '" .. tostring(name) ..
                               "' has exited with runtime error " .. res)
        else
          Actions.Log.warn("Lua coroutine '" .. tostring(name) .. "' exited")
        end

        coroutines[name] = nil

        break
      end
    end

    -- Run the dispatcher every 1 ms. Note, that this is required to prevent
    -- LuaChat from consuming 100% of a core. Note also that the notification
    -- value is set to the maximum value of a uint32_t to prevent conflicts
    -- with user timer ids (i.e. user timers can start from 0 and count up).
    timer(Actions.Timer.WaitType_BLOCK, 1, "ms", 0xffffffff)

  end
end

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

  -- Create a 'talk' object
  local talk
  if (args["server_port"]) then
    talk = Actions.Talk(args["server_port"])
  else
    talk = Actions.Talk()
  end

  -- Set the destination port to the default (if necessary)
  if (not args["port"]) then
    args["port"] = Actions.Talk.default_port
  end

  -- Create co-routines
  local coroutines = {}
  coroutines["receiver"] = coroutine.create(receiver)
  coroutine.resume(coroutines["receiver"], talk, args["host"], args["port"])

  coroutines["sender"] = coroutine.create(sender)
  coroutine.resume(coroutines["sender"], talk, args["host"], args["port"])

  -- Run the main loop
  dispatcher(coroutines)

end

local behaviour = {
  name = "LuaChat",
  description = "A Lua behaviour to allow users to chat over TCP",
  entry_point = main
}

return behaviour
