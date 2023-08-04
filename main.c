#include <GL/gl.h>
#include <GL/glut.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define WORLD_SIZE 128

struct timespec time;
struct timespec *time_handle;

struct colour
{
	float red;
	float green;
	float blue;
	float alpha;
};

struct colour new_colour(float red, float green, float blue, float alpha)
{
	struct colour col;
	col.red = red;
	col.green = green;
	col.blue = blue;
	col.alpha = alpha;
	return col;
}

struct particle
{
	uint mat;
	struct colour col;
	int ticked;
};

struct particle new_particle(struct colour col, uint mat)
{
	struct particle created;
	created.col = col;
	created.mat = mat;
	created.ticked = 0;
	return created;
}

struct particle world[WORLD_SIZE][WORLD_SIZE];

void setup()
{
	glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
}

void display()
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	for (int x = 0; x < WORLD_SIZE; x++)
	{
		for (int y = 0; y < WORLD_SIZE; y++)
		{
			float xp = ((float)x) / (((float)WORLD_SIZE) / 2.0f) - 1.0f;
			float yp = ((float)y) / (((float)WORLD_SIZE) / 2.0f) - 1.0f;
			struct colour cur_col = world[x][y].col;
			glColor3f(cur_col.red, cur_col.green, cur_col.blue);
			glRectf(xp, yp, xp + 2.0f / (float)WORLD_SIZE, yp + 2.0f / (float)WORLD_SIZE);
		}
	}
	glutSwapBuffers();
}

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

//unix microseconds
uint64_t cur_time()
{
	clock_gettime(NULL, time_handle);
	return time.tv_sec * 1000000 + time.tv_nsec / 1000;
}

float randf()
{
	return ((float)rand()) / ((float)(RAND_MAX));
}

enum type
{
	AIR,
	GAS,
	POWDER,
	LIQUID,
	STATIC,
};
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

int tick_x = 0;
int tick_y = WORLD_SIZE - 1;

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
			if (x >= WORLD_SIZE - 1)
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
			if (x >= WORLD_SIZE - 1)
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
	if (y >= WORLD_SIZE - 1)
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
		if (x >= WORLD_SIZE - 1)
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

void tick()
{
	glutPostRedisplay();
	world[tick_x][tick_y] = get_particle(randf() < 0.5 ? 1 : 2);
	tick_x += 1;
	tick_y -= tick_x / WORLD_SIZE;
	tick_x = tick_x % WORLD_SIZE;
	glutTimerFunc(0, tick, 0);
	for (int y = 0; y < WORLD_SIZE; y++)
	{
		for (int x = 0; x < WORLD_SIZE; x++)
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
	for (int y = 0; y < WORLD_SIZE; y++)
	{
		for (int x = 0; x < WORLD_SIZE; x++)
		{
			world[x][y].ticked = 0;
		}
	}
}

void init_world()
{
	for (int x = 0; x < WORLD_SIZE; x++)
	{
		for (int y = 0; y < WORLD_SIZE; y++)
		{
			if (abs(x - WORLD_SIZE / 2) < 2 || randf() < 0.1)
			{
				world[x][y] = get_particle(3);
			}
			else
			{
				world[x][y] = get_particle(0);
			}
		}
	}
}

int main(int argc, char **argv)
{
	time_handle = &time;
	srand((unsigned)gettimeofday(time_handle, NULL));
	while (1)
	{
			printf("%ld\n",cur_time());
			for(int i = 0; i < 100000000; i++)
			{

			}
		// printf("%ld\n", gettimeofday(time_handle, NULL));
		// fflush(stdout);
	}
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_DEPTH | GLUT_DOUBLE);
	glutInitWindowSize(800, 800);
	glutCreateWindow("Sand Sim");

	setup();
	glutDisplayFunc(display);
	init_world();
	glutTimerFunc(0, tick, 0);
	glutMainLoop();
	return 0;
}
