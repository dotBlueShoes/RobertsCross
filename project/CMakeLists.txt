# --- Add header files
file (GLOB_RECURSE HEADER_FILES
	${PROJECT_SOURCE_DIR}/inc/*.h
	${PROJECT_SOURCE_DIR}/inc/*.hpp
)

# --- Add needed DEFINE's
add_compile_definitions (_CRT_SECURE_NO_WARNINGS)

# --- Info Build Type
message (STATUS "Build type: ${CMAKE_BUILD_TYPE}")


if 		(${PROFILE} EQUAL 0)

	message (STATUS "Preset: Windows Debug")
	add_executable (${PROJECT_NAME} ${HEADER_FILES} # --- Define the executable
		src/main.cu 
		src/stb_image_implementation.cpp
	)

	# --- ! Might conflict when updating from CPP 17. -> _SILENCE_STDEXT_ARR_ITERS_DEPRECATION_WARNING
	add_compile_definitions (_SILENCE_STDEXT_ARR_ITERS_DEPRECATION_WARNING DEBUG_TOKEN)

elseif	(${PROFILE} EQUAL 1)

	message (STATUS "Preset: Windows Release")
	add_executable (${PROJECT_NAME} ${HEADER_FILES} # --- Define the executable
		src/main.cu 
		src/stb_image_implementation.cpp
	)
	
endif	()

# --- LIBS For shared by all presets.
target_link_libraries (${PROJECT_NAME} SPDLOG)
target_link_libraries (${PROJECT_NAME} STB)

# --- By default the CUDA compiler uses whole-program compilation. 
# ---  Effectively this means that all device functions and variables needed to be located inside a 
# ---  single file or compilation unit.
set_property (TARGET ${PROJECT_NAME} PROPERTY CUDA_SEPARABLE_COMPILATION ON)

# ---
set_property (TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 17)

# ---
target_include_directories (${PROJECT_NAME} PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}/inc
)

# --- Creates a 'symlink' for resources in builds directory.
add_custom_command (
	TARGET ${PROJECT_NAME} POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E create_symlink
	${CMAKE_SOURCE_DIR}/project/res
	${CMAKE_CURRENT_BINARY_DIR}/res
)
