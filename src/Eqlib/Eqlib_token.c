#include "Cal_type.h"
#include "Eqlib_token.h"
#include <stdlib.h>

Eq_tokened_t *tok_first = NULL;
Eq_tokened_t *tok_last = NULL;

Eq_tokened_t *tok_add(Eq_tokened_t *old_tok, Eq_unit_t *val, int start, int len)
{
	return old_tok;
}
Eq_tokened_t *tok_delete(Eq_tokened_t *tok)
{
	return tok;
}
void tok_delete_all(void)
{
}
Eq_tokened_t *tok_search_by_eq_unit(Eq_unit_t *search, int length)
{
	return tok_first;
}
Eq_tokened_t *tok_search_by_condition(int (*condition)(Eq_unit_t *, int), int length)
{
	return tok_first;
}
