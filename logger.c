struct log_info logs[256];
unsigned long t = 0;
int cur_log = -1;
void logger(char *new)
{
	unsigned long d;
	if (t == 0)
	{
		t = time_ns();
		d = 0;
	}
	else
	{
		unsigned long n = time_ns();
		d = n - t;
		t = n;
	}
	if (cur_log != -1)
	{
		logs[cur_log].time += d;
	}
	int found = 0;
	int last = -1;
	for (int i = 0; i < 256; i++)
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

void show_logs(unsigned long c)
{
	int last = -1;
	for (int i = 0; i < 256; i++)
	{
		if (str_len(logs[i].name) == 0)
		{
			last = i;
			break;
		}
	}
	// clear(); // slow for some reason? system commands = bad? maybe use ansi escape?
	unsigned long sum = 0;
	for (int i = 0; i < last; i++)
	{
		printf("%s: %luns\n", logs[i].name, logs[i].time); // prob security vuln
		sum += logs[i].time;
	}
	for (int i = 0; i < last; i++)
	{
		printf("%s: %f%%\n", logs[i].name, ((float)logs[i].time / (float)sum) * 100.0);
	}
	printf("total: %luns\n", sum);
	printf("sum fps: %f\n", (double)c / ((double)sum / 1000000000.0));
	fflush(stdout);
}
