#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 400
#define PIXEL_SIZE 5
#define WORLD_WIDTH (SCREEN_WIDTH / PIXEL_SIZE)
#define WORLD_HEIGHT (SCREEN_HEIGHT / PIXEL_SIZE)

struct timespec time;
struct timespec *time_handle;

struct colour
{
	float red;
	float green;
	float blue;
	float alpha;
};

struct particle
{
	uint mat;
	struct colour col;
	int ticked;
};

enum type
{
	AIR,
	GAS,
	POWDER,
	LIQUID,
	STATIC,
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

struct particle new_particle(struct colour col, uint mat)
{
	struct particle created;
	created.col = col;
	created.mat = mat;
	created.ticked = 0;
	return created;
}

// unix microseconds
uint64_t cur_time()
{
	clock_gettime(NULL, time_handle);
	return time.tv_sec * 1000000 + time.tv_nsec / 1000;
}

float randf()
{
	return ((float)rand()) / ((float)(RAND_MAX));
}
