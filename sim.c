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
	return 0;
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

unsigned long int tick_times[60];
int cur_tick_index = 0;

void tick_pos(int x, int y)
{

	struct particle cur = world[x][y];
	if (cur.ticked)
	{
		return;
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

void x_handler(int y, int bx, int by)
{
	if (cur_tick_index % 4 > 2)
	{
		for (int x = CHUNK_SIZE - 1; x >= 0; x--)
		{
			tick_pos(x + bx * CHUNK_SIZE, y + by * CHUNK_SIZE);
		}
	}
	else
	{
		for (int x = 0; x < CHUNK_SIZE; x++)
		{
			tick_pos(x + bx * CHUNK_SIZE, y + by * CHUNK_SIZE);
		}
	}
}

void tick_chunk(int bx, int by)
{
	if (cur_tick_index % 2 != 0)
	{
		for (int y = CHUNK_SIZE - 1; y >= 0; y--)
		{
			x_handler(y, bx, by);
		}
	}
	else
	{
		for (int y = 0; y < CHUNK_SIZE; y++)
		{
			x_handler(y, bx, by);
		}
	}
}

void tick_grid(int parity_x, int parity_y)
{
	for (int bx = parity_x; bx < (NUM_CHUNKS_X + 1 + parity_x) / 2; bx++)
	{
		for (int by = parity_y; by < (NUM_CHUNKS_Y + 1 + parity_y) / 2; by++)
		{
			tick_chunk(bx * 2 - parity_x, by * 2 - parity_y);
		}
	}
}

void tick()
{
	unsigned long int start = cur_time();
	for (int px = 0; px < 2; px++)
	{
		for (int py = 0; py < 2; py++)
		{
			tick_grid(px, py);
		}
	}
	for (int y = 0; y < WORLD_HEIGHT; y++)
	{

		for (int x = 0; x < WORLD_WIDTH; x++)
		{
			world[x][y].ticked = 0;
		}
	}

	tick_times[cur_tick_index] = cur_time() - start;
	cur_tick_index += 1;
	cur_tick_index = cur_tick_index % 60;
	int sum_time = 0;
	for (int i = 0; i < 60; i++)
	{
		sum_time += tick_times[i];
	}
	float last_tick_mean_time = ((float)sum_time) / 60.0f;
#ifdef DEBUG
	printf("tick:  %fms\n", last_tick_mean_time);
#endif
}
