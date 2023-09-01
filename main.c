#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
#ifdef _WIN32
#include <windows.h>
#else
#include <sys/time.h>
#endif
#define SDL_MAIN_HANDLED
#include <SDL.h>
#undef main

#include "utils.c"
#include "logger.c"
#include "material_defs.c"
#include "reaction.c"
#include "pixel.c"
#include "sim.c"
#include "render.c"
#include "input.c"

int main()
{
#ifndef _WIN32
	time_handle = &time_spec;
#endif
	srand(((long int)cur_time()) % (1 << 31));
	SDL_GetError();
	load_materials();
	init_sim();
	init_render();
	// printf("Init Done.\n");
	// long long z = cur_time();
	// for (int i = 0; i < (1 << 30); i++)
	// {
	// 	t_rand(&z);
	// 	printf("%lld\n",z);
	// }
	// return;
	for (unsigned long loop_count = 1; 1; loop_count++)
	{
		unsigned long start = cur_time();
		int quit = handle_input();
		if (quit)
		{
			printf("Quitting!\n");
			unload_materials();
			break;
		}
		// logger("tick");
		tick();
		display();
		logger("garbage");
		unsigned long end = cur_time();
		if (end > start)
		{ // stop sleeping for billion years if code is too fast
		  // SDL_Delay(10-min(end-start,10));
		}
		// SDL_Delay(10);
		if (loop_count % 10 == 0)
		{
			// show_logs(loop_count);
			// printf("%fFPS total\n", ((float)loop_count) / ((float)(cur_time() - ran) / 1000.0f));
		}
	}

	return 0;
}
