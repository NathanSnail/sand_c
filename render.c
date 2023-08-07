#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

SDL_Window *window;
SDL_Surface *surface;
SDL_Renderer *renderer;
SDL_Texture *texture;
SDL_Rect *texture_rect;
unsigned char screen[WORLD_HEIGHT][WORLD_WIDTH][4]; // consider that the struct probably alligns this correctly anyway

unsigned long int frame_times[60];
int cur_frame_index = 0;

void init_render()
{
	SDL_Init(0);
	window = SDL_CreateWindow("Sand Sim",SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED,SCREEN_WIDTH,SCREEN_HEIGHT,SDL_WINDOW_SHOWN);
	renderer = SDL_CreateRenderer(window,-1,0); // 0 is def wrong flags, but i dont know which ones are right
	texture = SDL_CreateTexture(renderer,SDL_PIXELFORMAT_RGBA8888,SDL_TEXTUREACCESS_STREAMING,WORLD_WIDTH,WORLD_HEIGHT);
	texture_rect = (SDL_Rect *)malloc(sizeof(SDL_Rect));
	texture_rect->x = 0;
	texture_rect->y = 0;
	texture_rect->w = WORLD_WIDTH;
	texture_rect->h = WORLD_HEIGHT;
}

void display()
{
	surface = SDL_GetWindowSurface(window); //SDL gets really angy if you reuse this
	unsigned long int start = cur_time();
	// for (int x = 0; x < SCREEN_WIDTH; x++)
	// {
	// 	for (int y = 0; y < SCREEN_HEIGHT; y++)
	// 	{
	// 		for (int c = 0; c < 4; c++)
	// 		{
	// 			screen[x][y][c] = 0x00;
	// 		}
	// 	}
	// }
	for (int x = 0; x < SCREEN_WIDTH / PIXEL_SIZE; x++)
	{
		for (int y = 0; y < SCREEN_HEIGHT / PIXEL_SIZE; y++)
		{
			struct colour cur_col = world[x][y].col;
			screen[y][x][0] = (unsigned char)(cur_col.red * 255.9);
			screen[y][x][1] = (unsigned char)(cur_col.green * 255.9);
			screen[y][x][2] = (unsigned char)(cur_col.blue * 255.9);
			screen[y][x][3] = 0xff;
		}
	}
	SDL_RenderCopy(renderer,texture,NULL,&texture_rect);

	//printf("place: %fms\n", ((float)(cur_time() - start)) / 1000.0f);
	frame_times[cur_frame_index] = cur_time() - start;
	cur_frame_index += 1;
	cur_frame_index = cur_frame_index % 60;
	int sum_time = 0;
	for (int i = 0; i < 60; i++)
	{
		sum_time += frame_times[i];
	}
	float last_frame_mean_time = ((float)sum_time) / 60.0f;
	float last_frame_ms_mean_time = last_frame_mean_time / 1000.0f;
	//printf("frame: %fms\n", last_frame_ms_mean_time);
	SDL_UpdateWindowSurface(window);
	printf("%s\n",SDL_GetError());
}
