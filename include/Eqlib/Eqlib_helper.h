#ifndef EQLIB_HELPER_H_ //#ifndef EQLIB_HELPER_H_ start
#define EQLIB_HELPER_H_ //define EQLIB_HELPER_H_

//header includings
#include "Cal_type.h"
#include "Eqlib_token.h"
#include "Arith.h"
#include "Braket.h"
#include "Func.h"


//eq_read helper
Eq_unit_t read_unit(void);
int read_unit_err(void);
int read_check_quit(Eq_t equation);


//eq_cal helper
void cal_token_eq(Eq_t equation, Err_t *to_error, Eq_tokened_t *to_token);
void cal_braket_matching(Err_t *to_error, Bk_t *to_braket);
void cal_with_brakets(Num_t *to_result, Err_t *to_error, Bk_t *to_braket, Eq_tokened_t *token);


//eq_print helper


#endif //#ifndef EQLIB_HELPER_H_ end
