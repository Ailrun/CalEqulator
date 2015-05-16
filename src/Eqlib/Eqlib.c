#include "Eqlib.h"
#include "Eqlib_helper.h"
#include "Eqlib_token.h"
#include <stdio.h>
#include <stdlib.h>

void eq_read(Eq_t *to_eq, Err_t *to_err)
{
	int i = 0, length = 20;
	Eq_unit_t temp;

	//initialize eq
	to_eq->eqarr = (Eq_unit_t *)malloc(sizeof(Eq_unit_t)*20);


	printf("EqJun << ");

	//get eq
	while ((temp = read_unit()) != 0)
	{
		to_eq->eqarr[length-20+i] = temp;
		i++;
		if (i == 20)
		{
			length += 20;
#ifdef DEBUG
			printf("call : realloc (%d : %s)\n", length, to_eq->eqarr);
#endif
			to_eq->eqarr = (Eq_unit_t *)realloc(to_eq->eqarr, sizeof(Eq_unit_t)*length);

			i = 0;
		}
	}

	//check Quit code
	if (read_check_quit(*to_eq))
	{
		to_err->errcode = QUIT;
	}
}

void eq_cal(Eq_t eq, Num_t *to_res, Err_t *to_err)
{
#ifdef DEBUG
	printf("eq_cal\n");
#endif

	Bk_t brakets;
	Eq_tokened_t *to_tok_eq = tok_add(NULL, NULL, 0, 0);

	//tokenizing
#ifdef DEBUG
	printf("call : cal_token_eq\n");
#endif
	cal_token_eq(eq, to_err, to_tok_eq);

	//find brakets
#ifdef DEBUG
		printf("call : cal_braket_matching\n");
#endif
	cal_braket_matching(to_err, &brakets);

	while (to_err->errcode == NORMAL_STATE && brakets.bkarr != NULL)
	{
		//Calculate all from inner braket to outer one
		cal_with_brakets(to_res, to_err, &brakets, to_tok_eq);
	}

	tok_delete_all();

}

void eq_print(Eq_t eq, Num_t res, Err_t err)
{
	printf("%s\n",eq.eqarr);
}
