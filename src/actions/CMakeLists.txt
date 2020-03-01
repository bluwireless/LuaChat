#[[

CMakeLists.txt - 'LuaChat' actions subdirectory build generation file.

Copyright © Blu Wireless. All Rights Reserved.
Licensed under the MIT license. See LICENSE file in the project.
Feedback: james.pascoe@bluwireless.com

]]

set(LUA_CHAT_SWIG_SRCS
    lua_chat_actions.i
    lua_chat_action_log.cpp
    lua_chat_action_talk.cpp
    lua_chat_action_timer.cpp)

set_source_files_properties(${LUA_CHAT_SWIG_SRCS} PROPERTIES CPLUSPLUS ON)
swig_add_library(actions
                 TYPE USE_BUILD_SHARED_LIBS
                 LANGUAGE lua
                 SOURCES ${LUA_CHAT_SWIG_SRCS})

target_include_directories(actions PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
                                           ${LUA_CHAT_SOURCE_DIR}/src
                                           ${LUA_CHAT_SOURCE_DIR}/third_party
                                           ${LUA_CHAT_SOURCE_DIR}/third_party/asio
                                           ${LUA_INCLUDE_DIR})

target_compile_definitions(actions PRIVATE ASIO_STANDALONE)

target_link_libraries(actions PRIVATE std::filesystem)
