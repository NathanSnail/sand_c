#include <GL/gl.h>
#include <GL/glut.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

void setup()
{
	glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
}

uint64_t frame_times[60];
int cur_frame_index = 0;

unsigned char screen[SCREEN_HEIGHT / PIXEL_SIZE][SCREEN_WIDTH / PIXEL_SIZE][4]; // consider that the struct probably alligns this correctly anyway

void display()
{
	uint64_t start = cur_time();
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	// for (int x = 0; x < SCREEN_WIDTH; x++)
	// {
	// 	for (int y = 0; y < SCREEN_HEIGHT; y++)
	// 	{
	// 		for (int c = 0; c < 4; c++)
	// 		{
	// 			screen[x][y][c] = 0x00;
	// 		}
	// 	}
	// }
	for (int x = 0; x < SCREEN_WIDTH / PIXEL_SIZE; x++)
	{
		for (int y = 0; y < SCREEN_HEIGHT / PIXEL_SIZE; y++)
		{
			struct colour cur_col = world[x][y].col;
			screen[y][x][0] = (unsigned char)(cur_col.red * 255.9);
			screen[y][x][1] = (unsigned char)(cur_col.green * 255.9);
			screen[y][x][2] = (unsigned char)(cur_col.blue * 255.9);
			screen[y][x][3] = 0xff;
		}
	}
	printf("place: %fms\n", ((float)(cur_time() - start)) / 1000.0f);
	// unsigned char pixels[100][4];
	// glPixelZoom(PIXEL_SIZE, PIXEL_SIZE);
	// glDrawPixels(SCREEN_WIDTH / PIXEL_SIZE, SCREEN_HEIGHT / PIXEL_SIZE, GL_RGBA, GL_UNSIGNED_BYTE, &screen);
	glutSwapBuffers();
	frame_times[cur_frame_index] = cur_time() - start;
	cur_frame_index += 1;
	cur_frame_index = cur_frame_index % 60;
	int sum_time = 0;
	for (int i = 0; i < 60; i++)
	{
		sum_time += frame_times[i];
	}
	float last_frame_mean_time = ((float)sum_time) / 60.0f;
	float last_frame_ms_mean_time = last_frame_mean_time / 1000.0f;
	printf("frame: %fms\n", last_frame_ms_mean_time);
}