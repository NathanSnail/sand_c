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
