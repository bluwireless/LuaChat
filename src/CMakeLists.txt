#[[

CMakeLists.txt - 'LuaChat' src subdirectory build generation file.

Copyright © Blu Wireless. All Rights Reserved.
Licensed under the MIT license. See LICENSE file in the project.
Feedback: james.pascoe@bluwireless.com

]]

add_subdirectory(actions)

add_executable(lua_chat lua_chat_main.cpp lua_chat_log_manager.cpp)

target_link_libraries(lua_chat
                      PRIVATE
                      actions
                      ${LUA_LIBRARIES}
                      std::filesystem
                      Threads::Threads)

target_include_directories(lua_chat
                           PRIVATE
                           ${CMAKE_CURRENT_SOURCE_DIR}
                           ${LUA_INCLUDE_DIR}
                           ${LUA_CHAT_SOURCE_DIR}/third_party)
