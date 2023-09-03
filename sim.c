long random_base = 16137;

int cur_tick_index = 0;

void tick_pos(int x, int y, long *rng)
{
	struct particle cur = world[x][y];
	react(x,y,cur.mat,rng);
	return;
	cur = world[x][y];
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
		world[x][y] = particles[0];
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
	return NULL;
}

void tick_grid(int parity_x, int parity_y)
{
	int c = 0;
	pthread_t thread_refs[NUM_CHUNKS_MAX];
	struct t_info thread_info[NUM_CHUNKS_MAX];
	logger("creation");
	for (int bx = parity_x; bx < NUM_CHUNKS_X; bx += 2)
	{
		for (int by = parity_y; by < NUM_CHUNKS_Y; by += 2)
		{
			printf("%ld\n",random_base);
			t_rand(&random_base); // this is float so yeah
			struct t_info pass = {bx,by,random_base};
			thread_info[c] = pass;
			pthread_create(&thread_refs[c],NULL,(void *(*)(void *))thread_process,&thread_info[c]);
			random_base+=c;
			c++;
		}
	}
	logger("joining");
	for (int i = 0; i < c; i++) // only slightly sus
	{
		pthread_join(thread_refs[i],NULL);
	}
}

int first_time = 1;

void tick()
{
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
	random_base = (float)(1l<<32)*randf();
	for (int x = 0; x < WORLD_WIDTH; x++)
	{
		for (int y = 0; y < WORLD_HEIGHT; y++)
		{
			/*if (abs(x - WORLD_WIDTH / 2) < 2 || randf() < 0.1)
			{
				world[x][y] = particles[3];
			}
			else if (randf() < 0.1)
			{
				world[x][y] = particles[1];
			}
			else if (randf() < 0.1)
			{
				world[x][y] = particles[2];
			}
			else
			{
				world[x][y] = particles[0];
			}*/
			world[x][y] = particles[randf() < 0.5 ? 1 : 2];
		}
	}
}
