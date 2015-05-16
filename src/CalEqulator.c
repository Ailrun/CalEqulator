#include "Eqlib.h"
#include "Eqlib_token.h"
#include <stdio.h>

int main(void)
{

	Eq_t p;
	Err_t err = {NORMAL_STATE, 0, 0};
	Num_t result;

	while (err.errcode != QUIT)
	{
#ifdef DEBUG
		printf("call : eq_read\n");
#endif
		eq_read(&p, &err);
		if (err.errcode == NORMAL_STATE)
		{
#ifdef DEBUG
			printf("call : eq_cal\n");
#endif
			eq_cal(p, &result, &err);
		}
#ifdef DEBUG
		printf("call : eq_print\n");
#endif
		eq_print(p, result, err);
	}

	return 0;
}
