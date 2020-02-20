// Copyright(c) 2020, James Pascoe
// Distributed under the MIT License (http://opensource.org/licenses/MIT)

#pragma once

#include <string>

#include "spdlog/spdlog.h"

class LogManager {

public:
  // This will throw on error
  static void initialise(std::string const& log_file_spec,
                         std::string const& log_level,
                         std::string const& log_file_level);

  // Default logging constants
  inline static const std::string def_log_lvl = "warning";
  inline static const std::string def_file_lvl = "info";
  inline static const std::string def_log_name = "logs/lua-chat.log";

private:

  LogManager() = default;
  ~LogManager() = default;

  // Do not allow the LogManager to be copied or moved.
  LogManager(LogManager const& rhs) = delete;
  LogManager(LogManager&& rhs) = delete;
  LogManager& operator=(LogManager const& rhs) = delete;
  LogManager& operator=(LogManager&& rhs) = delete;

  // Constants relating to the logger.
  inline static const std::string logger_name = "LUA-CHAT";

  // Constants relating to the rotating file sink. Note that max_file_size
  // is expressed in bytes files are rotated when they reach 1 MB in size.
  inline static const int max_file_size = 1024 * 1024;
  inline static const int max_num_files = 50;
};

// Wrap spdlog's logging primitives into generically named functions
template <typename... Args>
void log_trace(std::string const& format, Args const&... args) {
  spdlog::trace(format, args...);
}

template <typename... Args>
void log_debug(std::string const& format, Args const&... args) {
  spdlog::debug(format, args...);
}

template <typename... Args>
void log_info(std::string const& format, Args const&... args) {
  spdlog::info(format, args...);
}

template <typename... Args>
void log_warn(std::string const& format, Args const&... args) {
  spdlog::warn(format, args...);
}

template <typename... Args>
void log_error(std::string const& format, Args const&... args) {
  spdlog::error(format, args...);
}

template <typename... Args>
void log_critical(std::string const& format, Args const&... args) {
  spdlog::critical(format, args...);
}

// Add a function to signal a fatal error (and exit)
template <typename... Args>
void log_fatal(std::string const& format, Args const&... args) {
  auto error = fmt::format(format, args...);

  spdlog::critical(error);
  spdlog::critical("FATAL ERROR - EXITING");

  throw std::runtime_error(error);
}
