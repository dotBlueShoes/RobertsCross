#pragma once
#include "types.hpp"

enum DEBUG_TYPE: u64 {
	DEBUG_TYPE_UNKNOWN	= 1 << 0,
};

#ifndef DEBUG_FLAGS
const u64 DEBUG_FLAGS = DEBUG_TYPE_UNKNOWN;
#endif

#define DEBUG(debugFlags) if constexpr ((DEBUG_FLAGS & debugFlags) == debugFlags)
#define nameof(var) #var

#ifdef DEBUG_TOKEN

	#include <spdlog/spdlog.h>
	#include <spdlog/fmt/bin_to_hex.h>

	#define LogInfo(...) { \
		spdlog::info (__VA_ARGS__); \
	}

	#define LogWarn(...) { \
		spdlog::warn (__VA_ARGS__); \
	}

	#define LogErro(...) { \
		spdlog::error (__VA_ARGS__); \
	}

	#define Error(...) { \
		LogErro (__VA_ARGS__); \
		exit (1); \
	}

	// Non-Crittical Error
	#define ErrorSilent(...) { \
		LogErro (__VA_ARGS__); \
	}
	
#else

	#define LogInfo(...) {} // DUMMY
	#define LogWarn(...) {} // DUMMY
	#define LogErro(...) {} // DUMMY

	#define Error(...) { \
		exit (1); \
	}

	// Non-Crittical Error
	#define ErrorSilent(...) {} // DUMMY

#endif
