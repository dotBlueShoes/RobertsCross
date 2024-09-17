
### LIBARIES

# --- STB
set (STB_INC_DIR ${CMAKE_CURRENT_LIST_DIR}/stb)
add_library (STB INTERFACE)
target_include_directories (STB INTERFACE ${STB_INC_DIR})

# --- SPDLOG
set(SPDLOG_INC_DIR ${CMAKE_CURRENT_LIST_DIR}/spdlog/include)
add_library(SPDLOG INTERFACE)
target_include_directories(SPDLOG INTERFACE ${SPDLOG_INC_DIR})
