#define SCREEN_WIDTH 400
#define SCREEN_HEIGHT 400
#define PIXEL_SIZE 2
#define WORLD_WIDTH (SCREEN_WIDTH / PIXEL_SIZE)
#define WORLD_HEIGHT (SCREEN_HEIGHT / PIXEL_SIZE)
#define CHUNK_SIZE 40
#define NUM_CHUNKS_X (WORLD_WIDTH / CHUNK_SIZE)
#define NUM_CHUNKS_Y (WORLD_HEIGHT / CHUNK_SIZE)
#define NUM_CHUNKS_MAX ((int)(((float)NUM_CHUNKS_X)/2.0+0.9)*(int)(((float)NUM_CHUNKS_Y)/2.0+0.9))

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

enum chunk_state
{
	WAITING,
	PROCCESSING,
	DONE,
};

struct pos
{
	enum chunk_state state;
	int x;
	int y;
};

struct t_info
{
	int x;
	int y;
	long rng;
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
	created.ticked = WAITING;
	return created;
}

struct pos new_pos(int x, int y)
{
	struct pos created;
	created.x = x;
	created.y = y;
	created.state = WAITING;
	return created;
}

struct t_info new_t_info(int x, int y, long rng)
{
	struct t_info created;
	created.x = x;
	created.y = y;
	created.rng = rng;
	return created;
}

struct timespec time_spec;

#ifdef _WIN32		 // header part
void clock_gettime() // C-file part
{
	__int64 wintime;
	GetSystemTimeAsFileTime((FILETIME *)&wintime);
	wintime -= 116444736000000000i64;				 // 1jan1601 to 1jan1970
	time_spec.tv_sec = wintime / 10000000i64;		 // seconds
	time_spec.tv_nsec = wintime % 10000000i64 * 100; // nano-seconds
}
#else
struct timespec time_spec;
struct timespec *time_handle;
#endif

// unix microseconds
unsigned long int cur_time()
{
#ifdef _WIN32
	clock_gettime();
#else
	clock_gettime(0, time_handle);
#endif
	return time_spec.tv_sec * 1000 + time_spec.tv_nsec / 1000000;
}

float randf()
{
	return ((float)rand()) / ((float)(RAND_MAX));
}

#define MODULUS 1073741827
#define COEFF 536870923
#define ADD 268435459
float t_rand(long *rng) // simple LCG with primes because i think they make it less likely to be garbage
{
	*rng = (*rng * COEFF + ADD) % MODULUS;
	return (float)((double)(*rng)) / ((double)(MODULUS));
}

#define max(a, b) (((a) > (b)) ? (a) : (b))
#define min(a, b) (((a) < (b)) ? (a) : (b))
