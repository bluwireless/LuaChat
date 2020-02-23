/**
 * lua_chat_actions.i
 *
 * This is the SWIG interface file. This file tells SWIG which files
 * to wrap (i.e. make available in Lua) and also contains type mappings
 * plus any additional code that is required to allow the SWIG wrapper
 * to compile.
 *
 * Copyright © Blu Wireless. All Rights Reserved.
 * Licensed under the MIT license. See LICENSE file in the project.
 * Feedback: james.pascoe@bluwireless.com
 */

%module Actions

%include <std_string.i>

// Definitions required by the SWIG wrapper to compile
%{
#include "lua_chat_action_log.hpp"
%}

// Files to be wrapped by SWIG
%include "lua_chat_action_log.hpp"
