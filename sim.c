pthread_cond_t all_done;
pthread_cond_t tick_done;
pthread_mutex_t queue_lock = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t tick_dummy_lock = PTHREAD_MUTEX_INITIALIZER;
int tick_owned = 0;
#define QUEUE_SIZE ((int)((((float)NUM_CHUNKS_X) / 2.0f) + 0.999f)) * ((int)((((float)NUM_CHUNKS_Y) / 2.0f) + 0.999f))
struct pos queue[QUEUE_SIZE];
pthread_t threads[12];
int random_base = 1000;
pthread_mutex_t random_lock = PTHREAD_MUTEX_INITIALIZER;

struct particle world[WORLD_WIDTH][WORLD_HEIGHT];

int tick_powder(int x, int y, struct particle cur, int *rng)
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

void tick_liquid(int x, int y, struct particle cur, int *rng)
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

void tick_gas(int x, int y, struct particle cur, int *rng)
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

unsigned long int tick_times[60];
int cur_tick_index = 0;

void tick_pos(int x, int y, int *rng)
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

void x_handler(int y, int bx, int by, int *rng)
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

void tick_chunk(int bx, int by, int *rng)
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

void generate_queue(int parity_x, int parity_y)
{
	int c = 0;
	for (int bx = parity_x; bx < NUM_CHUNKS_X; bx += 2)
	{
		for (int by = parity_y; by < NUM_CHUNKS_Y; by += 2)
		{
			printf("%d %d\n",bx,by);
			queue[c] = new_pos(bx, by);
			c++;
		}
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
			// int res = pthread_mutex_unlock(&queue_lock);
			// printf("%d", res);
			if (!first_time)
			{
				while (!tick_owned)
				{
					pthread_cond_wait(&all_done, &queue_lock);
					printf("wakey wakey\n");
				}
			}
			generate_queue(px, py);
			first_time = 0;
			tick_owned = 0;
			pthread_mutex_lock(&tick_dummy_lock);
			pthread_cond_broadcast(&tick_done);
			pthread_mutex_unlock(&tick_dummy_lock);
			pthread_mutex_unlock(&queue_lock);
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

void *thread_process(void *arg)
{
	printf("created\n");
	pthread_mutex_lock(&random_lock);
	int rng = random_base;
	random_base += 1000;
	pthread_mutex_unlock(&random_lock);

	while (1)
	{
		while(tick_owned)
		{
			pthread_cond_wait(&tick_done,&tick_dummy_lock);
		}
		pthread_mutex_unlock(&tick_dummy_lock);
		int res = pthread_mutex_lock(&queue_lock); // take mutex to wait for access to the queue
		printf("got lock\n");
		if (tick_owned)
		{
			printf("bad dropped!\n");
			pthread_mutex_unlock(&queue_lock);
			continue;
		}
		int good = 1;
		int target = -1;
		for (int i = 0; i < QUEUE_SIZE; i++)
		{
			if (queue[i].state == WAITING)
			{
				target = i;
				break;
			}
		}
		for (int i = 0; i < QUEUE_SIZE; i++)
		{
			good = good && queue[i].state == DONE;
		}
		if (good)
		{
			printf("signal\n");
			tick_owned = 1;
			pthread_cond_signal(&all_done);
			pthread_mutex_unlock(&queue_lock);
			continue;
		}
		if (target == -1)
		{
			pthread_mutex_unlock(&queue_lock); // something something nested locking.
			continue;
		}
		queue[target].state = PROCCESSING;
		// vvvvv crashes for some reason.
		pthread_mutex_unlock(&queue_lock); // we have registered our claim on the chunk now, don't need lock anymore.
		tick_chunk(queue[target].x, queue[target].y, &rng);
		queue[target].state = DONE;
	}
	return NULL;
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
			else
			{
				world[x][y] = get_particle(0);
			}
		}
	}
	generate_queue(0, 0);
	pthread_cond_init(&all_done, NULL);
	pthread_cond_init(&tick_done, NULL);
	pthread_mutex_lock(&queue_lock);
	pthread_mutex_lock(&tick_dummy_lock);
	tick_owned = 1;
	for (int i = 0; i < 12; i++)
	{
		pthread_create(&threads[i], NULL, thread_process, NULL); // dispatch threads
	}
}
