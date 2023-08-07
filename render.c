SDL_Window *window;
SDL_Surface *surface;
SDL_Renderer *renderer;
SDL_Texture *texture;
unsigned char screen[WORLD_HEIGHT][WORLD_WIDTH][4]; // consider that the struct probably alligns this correctly anyway

unsigned long int frame_times[60];
int cur_frame_index = 0;

void init_render()
{
	int res = SDL_Init(0);
	if (res)
	{
		printf("!!!\n");
	}
	window = SDL_CreateWindow("Sand Sim", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
	renderer = SDL_CreateRenderer(window, -1, 0); // 0 is def wrong flags, but i dont know which ones are right
	texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGBA32, SDL_TEXTUREACCESS_STREAMING, WORLD_WIDTH, WORLD_HEIGHT);
}

void display()
{
	surface = SDL_GetWindowSurface(window); // SDL gets really angy if you reuse this
	unsigned long int start = cur_time();
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
	int res = SDL_UpdateTexture(texture, NULL, screen, 4 * WORLD_WIDTH);
	if (res)
	{
		printf("tex update = bad\n");
	}
	// unsigned char pixels[1][1] = {{0xff}};
	// SDL_Surface *surf = SDL_LoadBMP("example.bmp");
	// SDL_Texture *tex = SDL_CreateTextureFromSurface(renderer,surf);
	// SDL_UpdateTexture(texture,NULL,pixels,4);
	res = SDL_RenderCopy(renderer, texture, NULL, NULL);
	if (res)
	{
		printf("copy = bad\n");
	}
	// printf("place: %fms\n", ((float)(cur_time() - start)));
	frame_times[cur_frame_index] = cur_time() - start;
	cur_frame_index += 1;
	cur_frame_index = cur_frame_index % 60;
	int sum_time = 0;
	for (int i = 0; i < 60; i++)
	{
		sum_time += frame_times[i];
	}
	float last_frame_mean_time = ((float)sum_time) / 60.0f;
	// printf("frame: %fms\n", last_frame_ms_mean_time);
	SDL_RenderPresent(renderer);
	printf("%s\n", SDL_GetError());
}
