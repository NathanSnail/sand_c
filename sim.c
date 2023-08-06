struct particle world[WORLD_WIDTH][WORLD_HEIGHT];

int tick_powder(int x, int y, struct particle *cur)
{
	if (y > 0)
	{
		if (density[cur->mat] > density[world[x][y - 1].mat])
		{
			struct particle temp = world[x][y - 1];
			cur->ticked = 1;
			world[x][y - 1] = *cur;
			world[x][y] = temp;
			return 1;
		}
		int dir;
		if (randf() > 0.5)
		{
			if (x >= WORLD_WIDTH - 1)
			{
				return 1;
			}
			dir = 1;
		}
		else
		{
			if (x <= 0)
			{
				return 1;
			}
			dir = -1;
		}
		if (density[cur->mat] > density[world[x + dir][y - 1].mat])
		{
			struct particle temp = world[x + dir][y - 1];
			cur->ticked = 1;
			world[x + dir][y - 1] = *cur;
			world[x][y] = temp;
			return 1;
		}
		else
		{
			return 0;
		}
	}
}

void tick_liquid(int x, int y, struct particle *cur)
{
	if (!tick_powder(x, y, cur))
	{
		int dir;
		if (randf() > 0.5)
		{
			if (x >= WORLD_WIDTH - 1)
			{
				return;
			}
			dir = 1;
		}
		else
		{
			if (x <= 0)
			{
				return;
			}
			dir = -1;
		}
		if (density[cur->mat] > density[world[x + dir][y].mat])
		{
			struct particle temp = world[x + dir][y];
			cur->ticked = 1;
			world[x + dir][y] = *cur;
			world[x][y] = temp;
			return;
		}
	}
}

void tick_gas(int x, int y, struct particle *cur)
{
	if (y >= WORLD_HEIGHT - 1)
	{
		return;
	}
	if (density[cur->mat] > density[world[x][y + 1].mat])
	{
		struct particle temp = world[x][y + 1];
		cur->ticked = 1;
		world[x][y + 1] = *cur;
		world[x][y] = temp;
		return;
	}
	int dir;
	if (randf() > 0.5)
	{
		if (x >= WORLD_WIDTH - 1)
		{
			return;
		}
		dir = 1;
	}
	else
	{
		if (x <= 0)
		{
			return;
		}
		dir = -1;
	}
	if (density[cur->mat] > density[world[x + dir][y + 1].mat])
	{
		struct particle temp = world[x + dir][y + 1];
		cur->ticked = 1;
		world[x + dir][y + 1] = *cur;
		world[x][y] = temp;
		return;
	}
	if (density[cur->mat] > density[world[x + dir][y].mat])
	{
		struct particle temp = world[x + dir][y];
		cur->ticked = 1;
		world[x + dir][y] = *cur;
		world[x][y] = temp;
		return;
	}
}

uint64_t tick_times[60];
int cur_tick_index = 0;

void tick()
{
	world[0][WORLD_HEIGHT-1] = get_particle(1);
	world[WORLD_WIDTH-1][WORLD_HEIGHT-1] = get_particle(2);
	uint64_t start = cur_time();
	glutPostRedisplay();
	for (int y = 0; y < WORLD_HEIGHT; y++)
	{
		for (int x = 0; x < WORLD_WIDTH; x++)
		{
			struct particle cur = world[x][y];
			if (cur.ticked)
			{
				continue;
			}
			switch (types[cur.mat])
			{
			case AIR:
				break;
			case POWDER:
				tick_powder(x, y, &cur);
				break;
			case LIQUID:
				tick_liquid(x, y, &cur);
				break;
			case GAS:
				tick_gas(x, y, &cur);
				break;
			case STATIC:
				break;
			default:
				printf("invalid material @ %d %d", x, y);
				fflush(stdout);
				world[x][y] = get_particle(0);
			}
		}
	}
	for (int y = 0; y < WORLD_HEIGHT; y++)
	{
		for (int x = 0; x < WORLD_WIDTH; x++)
		{
			world[x][y].ticked = 0;
		}
	}
	glutTimerFunc(0, tick, 0);
	tick_times[cur_tick_index] = cur_time() - start;
	cur_tick_index += 1;
	cur_tick_index = cur_tick_index % 60;
	int sum_time = 0;
	for (int i = 0; i < 60; i++)
	{
		sum_time += tick_times[i];
	}
	float last_frame_mean_time = ((float)sum_time) / 60.0f;
	float last_tick_ms_mean_time = last_frame_mean_time / 1000.0f;
	printf("tick:  %fms\n", last_tick_ms_mean_time);
}
