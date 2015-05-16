#include "Eqlib_helper.h"
#include "Eqlib_token.h"
#include <stdio.h>
#include <string.h>

//eq_read helper
static int inerr = 0;

Eq_unit_t read_unit(void)
{
	Eq_unit_t temp = 0;

	temp = getchar();
	switch (temp)
	{
		case EOF :
				inerr = 1;
				temp = 0;
				break;
		case '\n' :
				temp = 0;
		default :
				inerr = 0;
				break;
	}

	return temp;
}

int read_check_quit(Eq_t eq)
{
	switch (strlen(eq.eqarr))
	{
		case 2 :
				 return !strncmp(eq.eqarr,"$q", 2);
		case 5 :
				 return !strncmp(eq.eqarr,"$quit", 5);
		default :
				return 0;
	}
}


//eq_cal helper
void cal_token_eq(Eq_t eq, Err_t *to_err, Eq_tokened_t *to_tok)
{
	int position = 0;
	int length = 0;

	while (*(eq.eqarr+position) != '\0')
	{
		braket_set(eq.eqarr+position, to_tok, position, &length);
		arith_set(eq.eqarr+position, to_tok, position, &length);
		func_set(eq.eqarr+position, to_tok, position, &length);
		braket_set(eq.eqarr+position, to_tok, position, &length);
		if (length == 0)
		{
			to_err->errcode = ILLEGAL_CHARACTER;
			to_err->char_num = position;
		}
		position += length;
		length = 0;
	}
}

void cal_braket_matching(Err_t *to_err, Bk_t *to_bk)
{
	int position = 0;
	Bk_t bk_stack = {NULL};
	Eq_tokened_t *to_tok = tok_first;

#ifdef DEBUG
	printf("cal_braket_matching[before while]\n");
#endif

	while (to_tok != tok_last)
	{
#ifdef DEBUG
		printf("cal_braket_matching[in while]\n");
#endif
		braket_check_from_first(to_bk, &bk_stack, to_tok, &position);
		if (bk_stack.bkarr != NULL)
		{
#ifdef DEBUG
			printf("cal_braket_matching[in while/in if]\n");
#endif
			switch (bk_stack.bkarr->kind)
			{
				case IL_BIG :
						 to_err->errcode = NOT_MATCH_BIG_RIGHT;
						 to_err->char_num = position;
						 return;
				case IL_MIDDLE :
						 to_err->errcode = NOT_MATCH_MIDDLE_RIGHT;
						 to_err->char_num = position;
						 return;
				case IL_SMALL :
						 to_err->errcode = NOT_MATCH_SMALL_RIGHT;
						 to_err->char_num = position;
						 return;
				default :
						 break;
			}
		}
	}
	if (bk_stack.bkarr != NULL)
	{
#ifdef DEBUG
		printf("cal_braket_matching[after while/in if]\n");
#endif
		switch (bk_stack.bkarr->kind)
		{
			case BIG :
					 to_err->errcode = NOT_MATCH_BIG_LEFT;
					 to_err->char_num = position;
					 break;
			case MIDDLE :
					 to_err->errcode = NOT_MATCH_MIDDLE_LEFT;
					 to_err->char_num = position;
					 break;
			case SMALL :
					 to_err->errcode = NOT_MATCH_SMALL_LEFT;
					 to_err->char_num = position;
					 break;
			default :
					 break;
		}
	}
}

void cal_with_brakets(Num_t *to_res, Err_t *to_err, Bk_t *to_bk, Eq_tokened_t *to_tok)
{
	to_bk->bkarr = NULL;
}
