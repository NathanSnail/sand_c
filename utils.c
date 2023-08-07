#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 400
#define PIXEL_SIZE 5
#define WORLD_WIDTH (SCREEN_WIDTH / PIXEL_SIZE)
#define WORLD_HEIGHT (SCREEN_HEIGHT / PIXEL_SIZE)

struct colour
{
	float red;
	float green;
	float blue;
	float alpha;
};

struct particle
{
	unsigned int mat;
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

struct particle new_particle(struct colour col, unsigned int mat)
{
	struct particle created;
	created.col = col;
	created.mat = mat;
	created.ticked = 0;
	return created;
}

#ifdef _WIN32
struct timespec
{
	long tv_sec;
	long tv_nsec;
};											  // header part
int clock_gettime(int _, struct timespec *spec) // C-file part
{
	__int64 wintime;
	GetSystemTimeAsFileTime((FILETIME *)&wintime);
	wintime -= 116444736000000000i64;			 // 1jan1601 to 1jan1970
	spec->tv_sec = wintime / 10000000i64;		 // seconds
	spec->tv_nsec = wintime % 10000000i64 * 100; // nano-seconds
	return 0;
}
#endif

struct timespec time_spec;
struct timespec *time_handle;

// unix microseconds
unsigned long int cur_time()
{

	clock_gettime(0, time_handle);
	return time_spec.tv_sec * 1000 + time_spec.tv_nsec / 1000000;
}

float randf()
{
	return ((float)rand()) / ((float)(RAND_MAX));
}
