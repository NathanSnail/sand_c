struct particle get_particle(int id)
{
	const struct particle particles[] =
		{
			new_particle(new_colour(0.2f, 0.3f, 0.6f, 1.0f), 0),
			new_particle(new_colour(1.0f, 1.0f, 0.0f, 1.0f), 1),
			new_particle(new_colour(0.0f, 0.0f, 0.7f, 0.5f), 2),
			new_particle(new_colour(0.2f, 0.2f, 0.2f, 0.5f), 3),
		};
	return particles[id];
}

enum type types[] = {
	AIR,
	POWDER,
	LIQUID,
	GAS,
};

float density[] = {
	0.0f,
	1.0f,
	0.5f,
	0.05f,
};
