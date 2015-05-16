#ifndef EQLIB_TOKEN_H_ //#ifndef EQLIB_TOKEN_H_ start
#define EQLIB_TOKEN_H_ //define EQLIB_TOKEN_H_

typedef struct Eq_tokened_t
{
	struct Eq_tokened_t *back;
	struct Eq_tokened_t *next;

	Eq_unit_t *token; // Eq_units : token
	int start;  // position of token
	int length; // length of token
} Eq_tokened_t;

extern Eq_tokened_t *tok_first;
extern Eq_tokened_t *tok_last;

Eq_tokened_t *tok_add(Eq_tokened_t *old_token, Eq_unit_t *token, int start, int length);
Eq_tokened_t *tok_delete(Eq_tokened_t *token);
Eq_tokened_t *tok_delete_all(void);
Eq_tokened_t *tok_search_by_eq_unit(Eq_unit_t *search, int length);
Eq_tokened_t *tok_search_by_condition(int (*condition)(Eq_unit_t *, int), int length);

#endif //#ifndef EQLIB_TOKEN_H_ end
