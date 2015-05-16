#ifndef BRAKET_H_ //#ifndef BRAKET_H_ start
#define BRAKET_H_ //define BRAKET_H_

#include "Cal_type.h"
#include "Eqlib_token.h"

typedef enum Bk_kind_t
{NOTHING, BIG, MIDDLE, SMALL, IL_BIG, IL_MIDDLE, IL_SMALL} Bk_kind_t;
typedef struct Bk_unit_t
{
	int left;
	int right;
	Bk_kind_t kind;
} Bk_unit_t;
typedef struct Bk_t
{
	Bk_unit_t *bkarr;
} Bk_t;

void braket_set(Eq_unit_t *equation, Eq_tokened_t *to_token, int position, int *length);
void braket_check_from_first(Bk_t *to_braket, Bk_t *braket_stack, Eq_tokened_t *to_token, int *length);
int isBraket(Eq_unit_t *equation, int length);

#endif //#ifndef BRAKET_H_ end
