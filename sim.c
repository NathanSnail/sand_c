long random_base = 16137;

struct particle world[WORLD_WIDTH][WORLD_HEIGHT];

int tick_powder(int x, int y, struct particle cur, long *rng)
{
	if (y > 0)
	{
		if (density[cur.mat] > density[world[x][y - 1].mat])
		{
			struct particle temp = world[x][y - 1];
			cur.ticked = 1;
			world[x][y - 1] = cur;
			world[x][y] = temp;
			return 1;
		}
		int dir;
		if (t_rand(rng) > 0.5)
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
		if (density[cur.mat] > density[world[x + dir][y - 1].mat])
		{
			struct particle temp = world[x + dir][y - 1];
			cur.ticked = 1;
			world[x + dir][y - 1] = cur;
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

void tick_liquid(int x, int y, struct particle cur, long *rng)
{
	if (!tick_powder(x, y, cur, rng))
	{
		int dir;
		if (t_rand(rng) > 0.5)
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
		if (density[cur.mat] > density[world[x + dir][y].mat])
		{
			struct particle temp = world[x + dir][y];
			cur.ticked = 1;
			world[x + dir][y] = cur;
			world[x][y] = temp;
			return;
		}
	}
}

void tick_gas(int x, int y, struct particle cur, long *rng)
{
	if (y >= WORLD_HEIGHT - 1)
	{
		return;
	}
	if (density[cur.mat] > density[world[x][y + 1].mat])
	{
		struct particle temp = world[x][y + 1];
		cur.ticked = 1;
		world[x][y + 1] = cur;
		world[x][y] = temp;
		return;
	}
	int dir;
	if (t_rand(rng) > 0.5)
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
	if (density[cur.mat] > density[world[x + dir][y + 1].mat])
	{
		struct particle temp = world[x + dir][y + 1];
		cur.ticked = 1;
		world[x + dir][y + 1] = cur;
		world[x][y] = temp;
		return;
	}
	if (density[cur.mat] > density[world[x + dir][y].mat])
	{
		struct particle temp = world[x + dir][y];
		cur.ticked = 1;
		world[x + dir][y] = cur;
		world[x][y] = temp;
		return;
	}
}

int cur_tick_index = 0;

void tick_pos(int x, int y, long *rng)
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
		tick_powder(x, y, cur, rng);
		break;
	case LIQUID:
		tick_liquid(x, y, cur, rng);
		break;
	case GAS:
		tick_gas(x, y, cur, rng);
		break;
	case STATIC:
		break;
	default:
		printf("invalid material @ %d %d", x, y);
		fflush(stdout);
		world[x][y] = get_particle(0);
	}
}

void x_handler(int y, int bx, int by, long *rng)
{
	if (cur_tick_index % 4 > 2)
	{
		for (int x = CHUNK_SIZE - 1; x >= 0; x--)
		{
			tick_pos(x + bx * CHUNK_SIZE, y + by * CHUNK_SIZE, rng);
		}
	}
	else
	{
		for (int x = 0; x < CHUNK_SIZE; x++)
		{
			tick_pos(x + bx * CHUNK_SIZE, y + by * CHUNK_SIZE, rng);
		}
	}
}

void tick_chunk(int bx, int by, long *rng)
{
	if (cur_tick_index % 2 != 0)
	{
		for (int y = CHUNK_SIZE - 1; y >= 0; y--)
		{
			x_handler(y, bx, by, rng);
		}
	}
	else
	{
		for (int y = 0; y < CHUNK_SIZE; y++)
		{
			x_handler(y, bx, by, rng);
		}
	}
}

void *thread_process(struct t_info *info)
{
	long rng = info->rng;
	tick_chunk(info->x, info->y, &rng);
}

void tick_grid(int parity_x, int parity_y)
{
	int c = 0;
	pthread_t thread_refs[NUM_CHUNKS_MAX];
	struct t_info thread_info[NUM_CHUNKS_MAX];
	for (int bx = parity_x; bx < NUM_CHUNKS_X; bx += 2)
	{
		for (int by = parity_y; by < NUM_CHUNKS_Y; by += 2)
		{
			t_rand(&random_base); // this is float so yeah
			thread_info[c] = new_t_info(bx,by,random_base);
			pthread_create(&thread_refs[c],NULL,(void *(*)(void *))thread_process,&thread_info[c]);
			random_base+=c;
			c++;
		}
	}
	for (int i = 0; i < c; i++) // only slightly sus
	{
		pthread_join(thread_refs[i],NULL);
	}
}

int first_time = 1;

void tick()
{
	unsigned long int start = cur_time();
	for (int px = 0; px < 2; px++)
	{
		for (int py = 0; py < 2; py++)
		{
			tick_grid(px,py);
		}
	}
	for (int y = 0; y < WORLD_HEIGHT; y++)
	{

		for (int x = 0; x < WORLD_WIDTH; x++)
		{
			world[x][y].ticked = 0;
		}
	}
}

void init_sim()
{
	for (int x = 0; x < WORLD_WIDTH; x++)
	{
		for (int y = 0; y < WORLD_HEIGHT; y++)
		{
			if (abs(x - WORLD_WIDTH / 2) < 2 || randf() < 0.1)
			{
				world[x][y] = get_particle(3);
			}
			else if (randf() < 0.1)
			{
				world[x][y] = get_particle(1);
			}
			else if (randf() < 0.1)
			{
				world[x][y] = get_particle(2);
			}
			else
			{
				world[x][y] = get_particle(0);
			}
		}
	}
}
