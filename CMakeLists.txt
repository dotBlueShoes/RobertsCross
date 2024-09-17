cmake_minimum_required (VERSION 3.27 FATAL_ERROR)

# --- Name, Version, Language compilers in use.
project (RobertsCross VERSION 1.0.0 LANGUAGES C CXX CUDA)

# --- Includes
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(properties)

# --- Dependencies
add_subdirectory(dependencies)

# --- Project's sources
add_subdirectory(project)
