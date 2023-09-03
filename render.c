SDL_Window *window;
SDL_Renderer *renderer;
SDL_Texture *texture;
unsigned char screen[SCREEN_PX_HEIGHT][SCREEN_PX_WIDTH][4]; // consider that the struct probably alligns this correctly anyway
long long cam_x = 0;
long long cam_y = 0;

void init_render()
{
	SDL_Init(0);
	SDL_GL_SetSwapInterval(0);
	window = SDL_CreateWindow("Sand Sim", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
	renderer = SDL_CreateRenderer(window, -1, 0); // 0 is def wrong flags, but i dont know which ones are right
	texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGBA32, SDL_TEXTUREACCESS_STREAMING, SCREEN_PX_WIDTH, SCREEN_PX_HEIGHT);
}

void display()
{
	logger("render");
	for (int x = cam_x; x < cam_x + SCREEN_PX_WIDTH; x++)
	{
		for (int y = cam_y; y < cam_y + SCREEN_PX_HEIGHT; y++)
		{
			struct colour cur_col = world[x][y].col;
			screen[SCREEN_PX_HEIGHT - y - 1][x][0] = (unsigned char)(cur_col.red * 255.9);
			screen[SCREEN_PX_HEIGHT - y - 1][x][1] = (unsigned char)(cur_col.green * 255.9);
			screen[SCREEN_PX_HEIGHT - y - 1][x][2] = (unsigned char)(cur_col.blue * 255.9);
			screen[SCREEN_PX_HEIGHT - y - 1][x][3] = (unsigned char)(cur_col.alpha * 255.9);
		}
	}
	logger("texture");
	SDL_UpdateTexture(texture, NULL, screen, 4 * SCREEN_PX_WIDTH);
	SDL_RenderCopy(renderer, texture, NULL, NULL);
	logger("present");
	SDL_RenderPresent(renderer);
}
