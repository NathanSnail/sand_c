#define CHUNK_SIZE 16
#define CHUNK_X 4
#define CHUNK_Y 4
#define PIXEL_SIZE 5
#define WORLD_WIDTH (CHUNK_X * CHUNK_SIZE)
#define WORLD_HEIGHT (CHUNK_Y * CHUNK_SIZE)
#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 240
#define SCREEN_PX_WIDTH (SCREEN_WIDTH / PIXEL_SIZE)
#define SCREEN_PX_HEIGHT (SCREEN_HEIGHT / PIXEL_SIZE)
#define NUM_CHUNKS_X (WORLD_WIDTH / CHUNK_SIZE)
#define NUM_CHUNKS_Y (WORLD_HEIGHT / CHUNK_SIZE)
#define NUM_CHUNKS_MAX ((int)(((float)NUM_CHUNKS_X) / 2.0 + 0.9) * (int)(((float)NUM_CHUNKS_Y) / 2.0 + 0.9))
#define NUM_REACTIONS 2
// fix this with csv loaders ^

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
	int reacted;
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
	long long rng;
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
	wintime -= 116444736000000000LL;				// 1jan1601 to 1jan1970
	time_spec.tv_sec = wintime / 10000000LL;		// seconds
	time_spec.tv_nsec = wintime % 10000000LL * 100; // nano-seconds
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

unsigned long long time_ns()
{
#ifdef _WIN32
	clock_gettime();
#else
	clock_gettime(0, time_handle);
#endif
	return time_spec.tv_sec * 1000000000LL + time_spec.tv_nsec;
}

float randf()
{
	return ((float)rand()) / ((float)(RAND_MAX));
}

#define MODULUS 9223372036854775807LL
#define COEFF 2862933555777941757LL
#define ADD 3037000493LL
float t_rand(long long *rng) // simple LCG with numbers i stole
{
	*rng = (*rng * COEFF + ADD) % MODULUS;
	long long combined = ((unsigned long long)(*rng) >> 12) | (1022LL << 52);
	return (*((double *)&combined) * 2.0 - 1.0);
	// this should always be correctly alligned because long long and double are the same size, as are there pointers.
	// might crash if called in a loop maybe where compiler tries to simd this?
}

int str_len(char *str)
{
	int i = 0;
	while ((*(str + i)) != '\0')
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
void clear()
{
#ifdef _WIN32
	system("cls");
#else
	system("clear");
#endif
}

#define max(a, b) (((a) > (b)) ? (a) : (b))
#define min(a, b) (((a) < (b)) ? (a) : (b))
