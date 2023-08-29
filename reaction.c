int c[4] = {0,0,0,0};
void react(int x,int y, unsigned int mat, long *rng)
{
	float r = t_rand(rng);
	int ox = 0;
	int oy = 0;
	if	(r < 0.25) 	{ox = 1;}
	else if	(r < 0.5)	{oy = 1;}
	else if	(r < 0.75) 	{ox = -1;}
	else			{oy = -1;}
	c[(ox+2)/3+((abs(oy)+2)/3)*2+(oy+1)/2]++;
	if (
	(x + ox < 0) || (x + ox >= WORLD_WIDTH) ||
	(y + oy < 0) || (y + oy >= WORLD_HEIGHT))
	{
		for(int i = 0; i < 4; i++)
		{
			printf("%d ",c[i]);
		}
		printf("\n");
		return;
	}
	unsigned int other = world[x+ox][y+oy].mat;
	r = t_rand(rng);
	for (int i = 0; i < NUM_REACTIONS; i++)
	{
		if (
		(mat == reactions[i].mat1) &&
		(other == reactions[i].mat2) &&
		(r < reactions[i].prob))
		{
			world[x][y] = particles[reactions[i].to1];
			world[x+ox][y+oy] = particles[reactions[i].to2];
			break;
		}
	}
}
