#include <GL/gl.h>
#include <GL/glut.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "utils.c"
#include "material_defs.c"
#include "sim.c"
#include "render.c"

void init_world()
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
}

int main(int argc, char **argv)
{
	printf("%x\n", (unsigned char)(0.5f * 255.99f));
	printf("%x\n", new_colour(1.0f, 1.0f, 2.0f, 3.0f));
	unsigned char d[2][4];
	d[2][0] = 0xDE;
	d[2][1] = 0xAD;
	d[2][2] = 0xBE;
	d[2][3] = 0xEF;
	printf("%x\n", &d);
	printf("%x\n", &d[1]);
	unsigned char *a = &d;
	*a = 0xabcdef01;

	printf("%x\n", d[0][1]);
	// exit(0);
	time_handle = &time;
	srand((unsigned)gettimeofday(time_handle, NULL));
	// while (1)
	// {
	// 	printf("%ld\n", cur_time());
	// 	for (int i = 0; i < 100000000; i++)
	// 	{
	// 	}
	// }
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_DEPTH | GLUT_DOUBLE);
	glutInitWindowSize(SCREEN_WIDTH, SCREEN_HEIGHT);
	glutCreateWindow("Sand Sim");

	setup();
	glutDisplayFunc(display);
	init_world();
	glutTimerFunc(0, tick, 0);
	glutMainLoop();
	return 0;
}
