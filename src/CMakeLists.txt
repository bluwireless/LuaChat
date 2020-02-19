# Copyright(c) 2019 James Pascoe
# Distributed under the MIT License (http://opensource.org/licenses/MIT)

add_executable(lua_chat lua_chat_main.cpp)

target_link_libraries(lua_chat PRIVATE ${LUA_LIBRARIES})

target_include_directories(lua_chat
                           PRIVATE
                           ${CMAKE_CURRENT_SOURCE_DIR}
                           ${LUA_INCLUDE_DIR})
