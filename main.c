#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define SDL_MAIN_HANDLED
#include <SDL.h>

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

int res;
int res_n = 0;

void test() {
	res_n++;
	if (res == -1) {
		printf("crash! @ %d\n",res_n);
	}
}

int main(int argc, char **argv)
{
	time_handle = &time;
	srand((unsigned)gettimeofday(time_handle, NULL));
	
	init_world();
	
	res = SDL_Init(0);
	test();
	window = SDL_CreateWindow("Sand Sim",SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED,SCREEN_WIDTH,SCREEN_HEIGHT,SDL_WINDOW_SHOWN);
	surface = SDL_GetWindowSurface(window);
	
	while (1) {
		int quit = handle_input();
		if(quit) {break;}
		display();
	}	

	return 0;
}
