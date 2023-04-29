#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

/**
 * main - Entry point
 *
 * Description: Create 5 zombie processes
 * Return: Always 0 (Success)
 */
int main(void)
{
	int i;
	pid_t zombie;
	int infinite_while(void);

	for (i = 0; i < 5; i++)
	{
		zombie = fork();
		if (zombie == 0)
			return (0);
		else
			printf("Zombie process created, PID: %d\n", zombie);
	}
	infinite_while();
	return (0);
}

/**
 * infinite_while - Infinite while loop
 *
 * Return: 0
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}
