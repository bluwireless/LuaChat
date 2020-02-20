# Copyright(c) 2020 James Pascoe
# Distributed under the MIT License (http://opensource.org/licenses/MIT)

cmake_minimum_required (VERSION 3.12)
project(LUA_CHAT DESCRIPTION
        "Example 'chat' application showing how to Combine C++17 and Lua 5.3")

include(cmake/pmm.cmake)
pmm(CMakeCM ROLLING)  # Enable the CMakeCM modules

# Include a module:
# Look for required packages
find_package(SWIG 3.0 REQUIRED)
include(${SWIG_USE_FILE})

find_package(Lua 5.3 REQUIRED)
find_package(Filesystem REQUIRED)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS NO)

add_subdirectory(src)
