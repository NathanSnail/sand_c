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
				cam_y--;
				break;
			case SDLK_s:
				cam_y++;
				break;
			case SDLK_a:
				cam_x--;
				break;
			case SDLK_d:
				cam_x++;
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
