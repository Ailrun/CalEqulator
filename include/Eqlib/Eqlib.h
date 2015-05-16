#ifndef EQLIB_H_ //#ifndef EQLIB_H_ start
#define EQLIB_H_ //EQLIB_H_ definition

#include "Cal_type.h"

void eq_read(Eq_t *to_equation, Err_t *to_error);
void eq_cal(Eq_t equation, Num_t *to_result, Err_t *to_error);
void eq_print(Eq_t equation, Num_t result, Err_t error);

#endif //#ifndef EQLIB_H_ end
