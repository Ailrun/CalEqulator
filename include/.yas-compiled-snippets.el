;;; Compiled snippets and support files for `include'
;;; Snippet definitions:
;;;
(yas-define-snippets 'include
                     '(("Cal_type.h" "#ifndef CAL_TYPE_H_ //#ifndef CAL_TYPE_H_ start\n#define CAL_TYPE_H_ //CAL_TYPE_H_ definition\n\n#define NORMSTR 0x00000000 //Prefix constant for normal condition\n#define COMPSTR 0x00010000 //Prefix constant for computational error\n#define MATHSTR 0x00020000 //Prefix constant for mathematical error\n#define EDITSTR 0x00040000 //Prefix constant for linguistic error\n\n/*\n#define NORMAL_STATE PRE_NORM+0x0\n#define OVERFLOW PRE_COMP+0x0\n#define DIVIDE_ZERO PRE_MATH+0x0\n#define NEGTIVE_SQRT PRE_MATH+0x1\n#define NOT_NUMBER PRE_EDIT+0x1\n#define NOT_MATCH_BIG_LEFT PRE_EDIT+0x2\n#define NOT_MATCH_BIG_RIGHT PRE_EDIT+0x3\n#define NOT_MATCH_MIDDLE_LEFT PRE_EDIT+0x4\n#define NOT_MATCH_MIDDLE_RIGHT PRE_EDIT+0x5\n#define NOT_MATCH_SMALL_LEFT PRE_EDIT+0x6\n#define NOT_MATCH_SMALL_RIGHT PRE_EDIT+0x7\n#define QUIT 0xFFFFFFFF\n*/\n\ntypedef enum Errcode_t\n{\n	NORMAL_STATE = NORMSTR, //NORMAL\n\n	OVERFLOW = COMPSTR, //\n\n	DIVIDE_ZERO = MATHSTR, NEGATIVE_SQRT,\n\n	ILLEGAL_CHARACTER = EDITSTR, NOT_MATCH_BIG_LEFT, NOT_MATCH_BIG_RIGHT,\n	NOT_MATCH_MIDDLE_LEFT, NOT_MATCH_MIDDLE_RIGHT, NOT_MATCH_SMALL_LEFT,\n	NOT_MATCH_SMALL_RIGHT, \n\n	QUIT = 0xFFFFFFFF\n} Errcode_t;\n\ntypedef struct Err_t\n{\n	Errcode_t errcode;\n	int line_num;\n	int char_num;\n} Err_t;\n\ntypedef char Eq_unit_t;\ntypedef struct Eq_t\n{\n	Eq_unit_t *eqarr;\n} Eq_t;\ntypedef double Num_t;\n\n#endif //#ifndef CAL_TYPE_H_ end\n" "Cal_type.h" nil nil nil nil nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'include
                     '(("Eqlib.h" "#ifndef EQLIB_H_ //#ifndef EQLIB_H_ start\n#define EQLIB_H_ //EQLIB_H_ definition\n\n#include \"Cal_type.h\"\n\nvoid eq_read(Eq_t *to_equation, Err_t *to_error);\nvoid eq_cal(Eq_t equation, Num_t *to_result, Err_t *to_error);\nvoid eq_print(Eq_t equation, Num_t result, Err_t error);\n\n#endif //#ifndef EQLIB_H_ end\n" "Eqlib.h" nil nil nil nil nil nil)
                       ("Eqlib_helper.h" "#ifndef EQLIB_HELPER_H_ //#ifndef EQLIB_HELPER_H_ start\n#define EQLIB_HELPER_H_ //define EQLIB_HELPER_H_\n\n//header includings\n#include \"Cal_type.h\"\n#include \"Eqlib_type.h\"\n#include \"Arith.h\"\n#include \"Braket.h\"\n#include \"Func.h\"\n\n\n//eq_read helper\nEq_unit_t read_unit(void);\nint read_unit_err(void);\nint read_check_quit(Eq_t equation);\n\n\n//eq_cal helper\nvoid cal_token_eq(Eq_t equation, Err_t *to_error, Eq_tokened_t *to_token);\nvoid cal_braket_matching(Err_t *to_error, Bk_t *to_braket, Eq_tokened_t *to_token);\nvoid cal_with_brakets(Num_t *to_result, Err_t *to_error, Bk_t *to_braket, Eq_tokened_t token);\n\n\n//eq_print helper\n\n#endif //#ifndef EQLIB_HELPER_H_ end\n" "Eqlib_helper.h" nil nil nil nil nil nil)
                       ("Eqlib_type.h" "#ifndef EQLIB_TYPE_H_ //#ifndef EQLIB_TYPE_H_ start\n#define EQLIB_TYPE_H_ //define EQLIB_TYPE_H_\n\ntypedef struct Eq_tokened_t\n{\n	struct Eq_tokened_t *first;\n	struct Eq_tokened_t *last;\n	struct Eq_tokened_t *back;\n	struct Eq_tokened_t *next;\n	\n	char *token;\n	int start;\n	int length;\n} Eq_tokened_t;\n\n#endif //#ifndef EQLIB_TYPE_H_ end\n" "Eqlib_type.h" nil nil nil nil nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'include
                     '(("Arith.h" "#ifndef ARITH_H_ //#ifndef ARITH_H_ start\n#define ARITH_H_ //ARITH_H_ define\n\n#include \"Cal_type.h\"\n#include \"Eqlib_type.h\"\n\nvoid arith_set(Eq_unit_t *equation, Eq_tokened_t *to_token, int *length);\n\n#endif //#ifndef ARITH_H_ end\n\n" "Arith.h" nil nil nil nil nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'include
                     '(("Braket.h" "#ifndef BRAKET_H_ //#ifndef BRAKET_H_ start\n#define BRAKET_H_ //define BRAKET_H_\n\n#include \"Cal_type.h\"\n#include \"Eqlib_type.h\"\n\ntypedef enum Bk_kind_t\n{BIG, MIDDLE, SMALL, IL_BIG, IL_MIDDLE, IL_SMALL} Bk_kind_t;\ntypedef struct Bk_unit_t\n{\n	int left;\n	int right;\n	Bk_kind_t kind;\n} Bk_unit_t;\ntypedef struct Bk_t\n{\n	Bk_unit_t *bkarr;\n} Bk_t;\n\nvoid braket_set(Eq_unit_t *equation, Eq_tokened_t *to_token, int *length);\nvoid braket_check_from_first(Bk_t *to_braket, Bk_t *braket_stack, Eq_tokened_t *to_token, int *length);\n\n#endif //#ifndef BRAKET_H_ end\n" "Braket.h" nil nil nil nil nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'include
                     '(("Func.h" "#ifndef FUNC_H_ //#ifndef FUNC_H_ start\n#define FUNC_H_ //define FUNC_H_\n\n#include \"Cal_type.h\"\n#include \"Eqlib_type.h\"\n\nvoid func_set(Eq_unit_t *equation, Eq_tokened_t *to_token, int *length);\n\n#endif //#ifndef FUNC_H_ end\n\n" "Func.h" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Wed May 13 15:43:56 2015
