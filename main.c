#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
#ifdef _WIN32
#include <windows.h>
// #include <timezone.h>
#else
#include <sys/time.h>
#endif
#define SDL_MAIN_HANDLED
#include <SDL.h>
#undef main

// #define DEBUG

#include "utils.c"
#include "material_defs.c"
#include "sim.c"
#include "render.c"
#include "input.c"
#include "logger.c"

// void *test(void *arg)
// {

// }

int main(int argc, char *argv[])
{
	#ifndef _WIN32
	time_handle = &time_spec;
	#endif
	srand(((long int)cur_time) % (1 << 31));
	logger("init");
	SDL_GetError();
	init_sim();
	init_render();
	unsigned long loop_count = 0;
	unsigned long ran = cur_time();
	printf("Init Done.\n");
	while(1)
	{
		loop_count++;
		unsigned long start = cur_time();
		int quit = handle_input();
		if (quit)
		{
			printf("Quitting!\n");
			break;
		}
		logger("tick");
		tick();
		logger("display");
		display();
		logger("garbage");
		unsigned long end = cur_time();
		if (end > start)
		{ // stop sleeping for billion years if code is too fast
		  // SDL_Delay(10-min(end-start,10));
		}
		// SDL_Delay(1000);
		if (loop_count % 1 == 0)
		{
			//show_logs();
			//printf("%fFPS total\n", ((float)loop_count) / ((float)(cur_time() - ran) / 1000.0f));
		}
	}

	return 0;
}
