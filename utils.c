#define WORLD_WIDTH 64
#define WORLD_HEIGHT 64
#define PIXEL_SIZE 1
#define SCREEN_WIDTH (WORLD_WIDTH * PIXEL_SIZE)
#define SCREEN_HEIGHT (WORLD_HEIGHT * PIXEL_SIZE)
#define CHUNK_SIZE 32
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

struct log_info
{
	char name[32];
	unsigned long time;
};

struct reaction
{
	unsigned int mat1;
	unsigned int mat2;
	unsigned int to1;
	unsigned int to2;
	float prob;
};

int str_len(char *str);

struct log_info new_log_info(char *name)
{
	struct log_info created;
	int l = str_len(name);
	for (int i = 0; i < l; i++)
	{
		*(created.name + i) = *(name + i);
	}
	*(created.name + l) = '\0';
	created.time = 0;
	return created;
}

struct timespec time_spec;

#ifdef _WIN32
void clock_gettime()
{
	__int64 wintime;
	GetSystemTimeAsFileTime((FILETIME *)&wintime);
	wintime -= 116444736000000000i64;			// 1jan1601 to 1jan1970
	time_spec.tv_sec = wintime / 10000000i64;		// seconds
	time_spec.tv_nsec = wintime % 10000000i64 * 100;	// nano-seconds
}
#else
struct timespec time_spec;
struct timespec *time_handle;
#endif

// unix miliseconds
unsigned long cur_time()
{
#ifdef _WIN32
	clock_gettime();
#else
	clock_gettime(0, time_handle);
#endif
	return time_spec.tv_sec * 1000 + time_spec.tv_nsec / 1000000;
}

unsigned long time_ns()
{
	#ifdef _WIN32
	clock_gettime();
	#else
	clock_gettime(0, time_handle);
	#endif
	return time_spec.tv_sec * 1000000000 + time_spec.tv_nsec;
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

int str_len(char *str)
{
	int i = 0;
	while((*(str + i)) != '\0')
	{
		i++;
	}
	return i;
}

int str_eq(char *a, char *b)
{
	int l = str_len(a);
	if (l != str_len(b))
	{
		return 0;
	}
	for (int i = 0; i < l; i++)
	{
		if (*(a + i) != *(b + i))
		{
			return 0;
		}
	}
	return 1;
}

// ew
void clear() {
	#ifdef _WIN32
	system("cls");
	#else
	system("clear");
	#endif
}

#define max(a, b) (((a) > (b)) ? (a) : (b))
#define min(a, b) (((a) < (b)) ? (a) : (b))
