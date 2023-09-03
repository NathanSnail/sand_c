struct particle world[WORLD_WIDTH][WORLD_HEIGHT];

struct particle *particles;
enum type *types;
float *density;

void line_loop(FILE *f, int pid)
{
	particles[pid].ticked = 0;
	particles[pid].reacted = 0;
	char ch;
	do
	{
		ch = fgetc(f);
		// printf("%c", ch);
	} while (ch != ','); // clear name
	int len = 1;
	char *str = malloc(sizeof(char) * len);
	int field = 0;
	*str = '\0';
	do
	{
		ch = fgetc(f);
		if (ch == ',')
		{
			printf("%d %s\n", field, str);
			len = 1;
			switch (field)
			{
			case 0:
				if (str_eq(str, "air"))
				{
					types[pid] = AIR;
				}
				else if (str_eq(str, "gas"))
				{
					types[pid] = GAS;
				}
				else if (str_eq(str, "powder"))
				{
					types[pid] = POWDER;
				}
				else if (str_eq(str, "liquid"))
				{
					types[pid] = LIQUID;
				}
				else if (str_eq(str, "static"))
				{
					types[pid] = STATIC;
				}
				break;
			case 1:
				particles[pid].col.red = atof(str);
				break;
			case 2:
				particles[pid].col.green = atof(str);
				break;
			case 3:
				particles[pid].col.blue = atof(str);
				break;
			case 4:
				particles[pid].col.alpha = atof(str);
				break;
			case 5:
				printf("density is dense\n");
				density[pid] = atof(str);
				break;
			default:
				break;
			}
			free(str);
			str = malloc(sizeof(char) * len);
			*str = '\0';
			field++;
		}
		else
		{
			len++;									// expand space requirements
			char *tmp = malloc(sizeof(char) * len); // allocate the working space
			strcpy(tmp, str);						// copy current over
			strncat(tmp, &ch, 1);					// expand with new char
			free(str);								// prepare to swap back
			str = malloc(sizeof(char) * len);		// realloc
			strcpy(str, tmp);						// copy back
			free(tmp);								// free stuff
		}
	} while (ch != '\n');
	particles[pid].mat = pid;
	free(str);
	printf("%d\n", pid);
	printf("%d\n", types[pid]);
	printf("%f\n", particles[pid].col.red);
}

void load_materials()
{
	FILE *f = fopen("materials.csv", "r");
	int newlines = 0;
	char ch;
	do
	{
		ch = fgetc(f);
		if (ch == '\n')
		{
			newlines++;
		}
	} while (ch != EOF);
	newlines -= 1;
	printf("%d\n", newlines);
	particles = malloc(sizeof(struct particle) * newlines);
	types = malloc(sizeof(enum type) * newlines);
	density = malloc(sizeof(float) * newlines);
	int pid = 0;
	rewind(f);
	do
	{
		ch = fgetc(f);
		// printf("%c", ch);
	} while (ch != '\n'); // clear the first line
	do
	{
		ch = fgetc(f); // this destroys the first char but whatever
		if (ch == EOF)
		{
			break;
		}
		line_loop(f, pid);
		pid++;
	} while (ch != EOF);
	fclose(f);
}

void unload_materials()
{
	free(particles);
	free(density);
	free(types);
}

struct reaction reactions[NUM_REACTIONS] = {
	{0, 3, 0, 0, 0.05},
	{1, 2, 2, 1, 1.0},
};

/*
struct reaction get_reaction(int id)
{
	const struct particle particles[] =
		{
			new_particle(new_colour(0.6f, 0.6f, 0.6f, 1.0f), 0),
			new_particle(new_colour(1.0f, 1.0f, 0.0f, 1.0f), 1),
			new_particle(new_colour(0.0f, 0.0f, 0.7f, 0.5f), 2),
			new_particle(new_colour(0.2f, 0.2f, 0.2f, 0.5f), 3),
		};
	return particles[id];
}
*/
