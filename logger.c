struct log_info logs[256];
unsigned long t = 0;
int cur_log = -1;
void logger(char *new)
{
	unsigned long d;
	if (t == 0)
	{
		t = cur_time();
	}
	else
	{
		unsigned long n = cur_time();
		d = n - t;
		t = n;
	}
	if (cur_log != -1)
	{
		logs[cur_log].time += d;
	}
	int found = 0;
	int last = -1;
	for(int i = 0; i < 256; i++)
	{
		if (str_len(logs[i].name) == 0)
		{
			last = i;
			break;
		}
		if (str_eq(logs[i].name, new))
		{
			cur_log = i;
			found = 1;
			break;
		}
	}
	if (!found)
	{
		logs[last] = new_log_info(new);
		cur_log = last;
	}
}

void show_logs()
{
	int last = -1;
	for(int i = 0; i < 256; i++)
	{
		if (str_len(logs[i].name) == 0)
		{
			last = i;
			break;
		}
	}
	clear();
	for(int i = 0; i < last; i++)
	{
		printf("%s: %lums\n",logs[i].name, logs[i].time); // prob security vuln
	}
	fflush(stdout);
}
