#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2021 Liviu Ionescu
#
# This Source Code Form is subject to the terms of the MIT License.
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# This file defines the global settings that apply to all targets.

# -----------------------------------------------------------------------------
# The current folder.

get_filename_component(xpack_current_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

# -----------------------------------------------------------------------------
# Global settings. Must be called before defining any libraries.

include_directories(

  # The platform defines the <micro-os-plus/config.h> header, to be
  # passed to all sources.
  ${xpack_current_folder}/include
)

add_compile_definitions(

  HAVE_MICRO_OS_PLUS_CONFIG_H

  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:MICRO_OS_PLUS_USE_TRACE_POSIX_STDOUT>
  )

xpack_set_all_compiler_warnings(all_warnings)

set(common_options 

  -fmessage-length=0
  -fsigned-char

  -ffunction-sections
  -fdata-sections

  ${all_warnings}

  -Werror
)

add_compile_options(

  ${common_options}
)

add_link_options(

  ${common_options}
)

add_link_options(
  
  # GCC specific
  $<$<CXX_COMPILER_ID:GNU>:-Wl,--gc-sections>
)

# -----------------------------------------------------------------------------
