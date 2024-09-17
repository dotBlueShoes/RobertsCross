#include "debug.hpp"
#include "cuda.hpp"

namespace IMAGE {

	const u8 CHANNELS = 3; // Hack! We're hardcodding image channels to 3!

	void Load (
		/* IN  */ const u8* image,
		/* IN  */ const u32& imageCount,
		/* OUT */ r32*& output
	) {
		output = new r32[imageCount / CHANNELS];

		s32 sum = 0;

		for (u32 i = 0; i < imageCount; ++i) {
			sum += image[i];
			if ((i + 1) % CHANNELS == 0) {
				output[i / CHANNELS] = (sum / 3.f) / 255.f;
				sum = 0;
			}
		}
	}

	void Save (
		/* IN  */ const r32* image,
		/* IN  */ const u32& imageCount,
		/* OUT */ u8*& output
	) {
		output = new u8[imageCount * CHANNELS];

		for (u32 i = 0; i < imageCount; ++i) {
			for (u32 j = 0; j < CHANNELS; ++j) {
				output[i * CHANNELS + j] = image[i] * 255;
			}
		}
	}

}


namespace GPU {

	const u8 BLOCK_SIZE = 32;

	__global__ void RobertsFilter (
		/* IN  */ const r32*    iPixels,    //
		/* OUT */ r32*          oPixels,    //
		/* IN  */ s32           width,      //
		/* IN  */ s32           height,     //
		/* IN  */ s32           strength,   //
		/* IN  */ s32           mode        //
	) {
		u32 x = blockIdx.x * blockDim.x + threadIdx.x;
		u32 y = blockIdx.y * blockDim.y + threadIdx.y;

		if (x < width - 1 && y < height - 1) {
			r32 gx = iPixels[y * width + x] - iPixels[(y + strength) * width + (x + strength)];
			r32 gy = iPixels[y * width + (x + strength)] - iPixels[(y + strength) * width + x];

			if (mode == 2) gy = 0.0;                            // GX only
			if (mode == 3) gx = 0.0;                            // GY only

			r64 magnitude = sqrtf ((r32)(gx * gx + gy * gy));

			if (mode == 4) magnitude = 1 - magnitude;           // Inverse mode

			oPixels[y * width + x] = (r32)(magnitude);
		}

	}

}


s32 main() {

	DEBUG (DEBUG_TYPE_UNKNOWN) LogInfo ("Entered Roberts Cross execution!");
	
	s32 width;
	s32 height;
	s32 rgb;
	u8* image;
	u32 imageSize;

	r32* cpuI;
	r32* cpuO;
	r32* gpuI;
	r32* gpuO;

	s32 mode;
	s32 fileId;
	
	s32 strength (1); // default
	

	{ // Menu creation, input read, validation

		printf (
			"Select Mode:\n"
			" -> 1. both\n"
			" -> 2. gx\n"
			" -> 3. gy\n"
			" -> 4. inverse\n"
			" : "
		);
		scanf ("%i", &mode);

		printf ("Select file (0-4): ");
		scanf ("%i", &fileId);
	
		printf ("Algorithm strength: ");
		scanf ("%i", &strength);

		putc ('\n', stdout);

		if (mode > 4 || mode < 1) { mode = 1; }
		if (fileId > 4 || fileId < 0) { fileId = 0; }

	}

	{ // Loading image
		DEBUG (DEBUG_TYPE_UNKNOWN) LogInfo ("Loading Image");

		auto&& filePath = files[fileId];
		image = stbi_load (filePath, &width, &height, &rgb, IMAGE::CHANNELS);

		DEBUG (DEBUG_TYPE_UNKNOWN) if (image == nullptr) {
			Error ("Could not load the image.");
		}

		IMAGE::Load (image, width * height * IMAGE::CHANNELS, cpuI);
		imageSize = width * height * sizeof (u32);
	}

	{ // CPU allocations
		cpuO = (r32*) malloc (imageSize);
	}
	
	{ // GPU allocations
		cudaMalloc ((void**)&gpuI, imageSize);
		cudaMalloc ((void**)&gpuO, imageSize);
		cudaMemcpy (gpuI, cpuI, imageSize, cudaMemcpyHostToDevice);
	}
	
	{ // Processing
		dim3 blockSize (GPU::BLOCK_SIZE, GPU::BLOCK_SIZE, 1);

		dim3 gridSize (
			(width + blockSize.x - 1) / blockSize.x,
			(height + blockSize.y - 1) / blockSize.y,
			1
		);

		DEBUG (DEBUG_TYPE_UNKNOWN) LogInfo ("Processing");

		GPU::RobertsFilter <<<gridSize, blockSize>>> (gpuI, gpuO, width, height, strength, mode);

		cudaMemcpy (cpuO, gpuO, imageSize, cudaMemcpyDeviceToHost);
	}
	
	{ // Outputting
		DEBUG (DEBUG_TYPE_UNKNOWN) LogInfo ("Outputting");
	
		// We're reusing this memory...
		stbi_image_free (image);
	
		IMAGE::Save (cpuO, width * height, image);
	
		stbi_write_png (
			OF, width, height, IMAGE::CHANNELS,
			image, width * IMAGE::CHANNELS
		);
	}
	
	{ // Freeing
		cudaFree (gpuI);
		cudaFree (gpuO);
		free (cpuI);
		free (cpuO);
	}

	DEBUG (DEBUG_TYPE_UNKNOWN) LogInfo ("Finished execution.");

	return 0;
}
