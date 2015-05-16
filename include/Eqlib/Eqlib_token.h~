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

Eq_tokened_t *tok_first;
Eq_tokened_t *tok_last;

Eq_tokened_t *add_eq_token(Eq_tokened_t *old_token, int start, int length);
Eq_tokened_t *delete_eq_token(Eq_tokened_t *rm_token);
Eq_tokened_t *search_eq_unit(Eq_unit_t *search, int length);

#endif //#ifndef EQLIB_TOKEN_H_ end
