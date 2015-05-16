#include "Braket.h"
#include "Eqlib_token.h"
#include <stdlib.h>

void braket_set(Eq_unit_t *eq, Eq_tokened_t *to_tok, int pos, int *len)
{
	if (isBraket(eq, 1))
	{
		to_tok = tok_add(to_tok, *eq, pos, 1);
		*len = 1;
	}
x}

void braket_check_from_first(Bk_t *to_bk, Bk_t *bk_stack, Eq_tokened_t *to_tok, int *len)
{
	Eq_tokened_t *braket = tok_search_by_condition(isBraket, 1);
}

int isBraket(Eq_unit_t *eq, int len)
{
	switch(*eq)
	{
		case '(' :

	}
}
