#pragma once


#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <stdio.h>
#include <stb_image.h>
#include <stb_image_write.h>
#include "types.hpp"

#define RES_FILEPATH "res\\"

const c8* F1 = RES_FILEPATH "i_1.jpg";
const c8* F2 = RES_FILEPATH "i_2.jpg";
const c8* F3 = RES_FILEPATH "i_3.jpg";
const c8* F4 = RES_FILEPATH "i_4.jpg";
const c8* F5 = RES_FILEPATH "i_5.jpg";

const c8* OF = RES_FILEPATH "output.jpg";

const c8* files[] { F1, F2, F3, F4, F5 };
