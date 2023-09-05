int handle_input()
{
	SDL_Event event;
	while (SDL_PollEvent(&event))
	{
		switch (event.type)
		{
		case SDL_KEYDOWN:
		{
			switch (event.key.keysym.sym)
			{
			case SDLK_ESCAPE:
				return 1;
			case SDLK_w:
				if (SCREEN_PX_HEIGHT + cam_y < WORLD_HEIGHT)
				{
					cam_y++;
				}
				break;
			case SDLK_s:
				if (cam_y > 0)
				{
					cam_y--;
				}
				break;
			case SDLK_a:
				if (cam_x > 0)
				{
					cam_x--;
				}
				break;
			case SDLK_d:
				if (SCREEN_PX_WIDTH + cam_x < WORLD_WIDTH)
				{
					cam_x++;
				}
				break;
			}
			break;
		}
		case SDL_QUIT:
		{
			return 1;
		}
		}
	}
	return 0;
}
