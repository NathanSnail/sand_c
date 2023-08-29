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
