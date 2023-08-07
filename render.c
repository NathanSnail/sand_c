SDL_Window *window;
SDL_Renderer *renderer;
SDL_Texture *texture;
unsigned char screen[WORLD_HEIGHT][WORLD_WIDTH][4]; // consider that the struct probably alligns this correctly anyway

unsigned long int frame_times[60];
int cur_frame_index = 0;

void init_render()
{
	SDL_Init(0);
	window = SDL_CreateWindow("Sand Sim", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
	renderer = SDL_CreateRenderer(window, -1, 0); // 0 is def wrong flags, but i dont know which ones are right
	texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGBA32, SDL_TEXTUREACCESS_STREAMING, WORLD_WIDTH, WORLD_HEIGHT);
}

void display()
{
	unsigned long int start = cur_time();
	for (int x = 0; x < WORLD_WIDTH; x++)
	{
		for (int y = 0; y < WORLD_HEIGHT; y++)
		{
			struct colour cur_col = world[x][y].col;
			screen[WORLD_HEIGHT - y - 1][x][0] = (unsigned char)(cur_col.red * 255.9);
			screen[WORLD_HEIGHT - y - 1][x][1] = (unsigned char)(cur_col.green * 255.9);
			screen[WORLD_HEIGHT - y - 1][x][2] = (unsigned char)(cur_col.blue * 255.9);
			screen[WORLD_HEIGHT - y - 1][x][3] = (unsigned char)(cur_col.alpha * 255.9);
		}
	}
	printf("place: %fms\n", ((float)(cur_time() - start)));
	SDL_UpdateTexture(texture, NULL, screen, 4 * WORLD_WIDTH);
	SDL_RenderCopy(renderer, texture, NULL, NULL);
	frame_times[cur_frame_index] = cur_time() - start;
	cur_frame_index += 1;
	cur_frame_index = cur_frame_index % 60;
	int sum_time = 0;
	for (int i = 0; i < 60; i++)
	{
		sum_time += frame_times[i];
	}
	float last_frame_mean_time = ((float)sum_time) / 60.0f;
	printf("frame: %fms\n", last_frame_mean_time);
	SDL_RenderPresent(renderer);
}
