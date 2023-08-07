#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

#define SDL_MAIN_HANDLED
#include <SDL.h>
#undef main

#include "utils.c"
#include "material_defs.c"
#include "sim.c"
#include "render.c"
#include "input.c"

void init_world()
{
	for (int x = 0; x < WORLD_WIDTH; x++)
	{
		for (int y = 0; y < WORLD_HEIGHT; y++)
		{
			if (abs(x - WORLD_WIDTH / 2) < 2 || randf() < 0.1)
			{
				world[x][y] = get_particle(3);
			}
			else
			{
				world[x][y] = get_particle(0);
			}
		}
	}
}

int main(int argc, char *argv[])
{
	time_handle = &time_spec;
	srand(((long int)cur_time) % (1 << 31));
	SDL_GetError();
	init_world();
	init_render();
	
	while (1) {
		int quit = handle_input();
		if(quit) {break;}
		display();
	}	

	return 0;
}
