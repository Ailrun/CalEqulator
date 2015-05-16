;;; Compiled snippets and support files for `src'
;;; Snippet definitions:
;;;
(yas-define-snippets 'src
                     '(("CalEqulator.c" "#include <stdio.h>\n#include \"Eqlib.h\"\n\nint main(void)\n{\n	Eq_t p;\n	Err_t err = {NORMAL_STATE, 0, 0};\n	Num_t result;\n\n	while (err.errcode != QUIT)\n	{\n#ifdef DEBUG\n		printf(\"call : eq_read\\n\");\n#endif\n		eq_read(&p, &err);\n		if (err.errcode == NORMAL_STATE)\n		{\n#ifdef DEBUG\n			printf(\"call : eq_cal\\n\");\n#endif\n			eq_cal(p, &result, &err);\n		}\n#ifdef DEBUG\n		printf(\"call : eq_print\\n\");\n#endif\n		eq_print(p, result, err);\n	}\n\n	return 0;\n}\n" "CalEqulator.c" nil nil nil nil nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'src
                     '(("Eqlib.c" "#include \"Eqlib.h\"\n#include \"Eqlib_helper.h\"\n#include <stdio.h>\n#include <stdlib.h>\n\nvoid eq_read(Eq_t *to_eq, Err_t *to_err)\n{\n	int i = 0, length = 20;\n	Eq_unit_t temp;\n\n	//initialize eq\n	to_eq->eqarr = (Eq_unit_t *)malloc(sizeof(Eq_unit_t)*20);\n\n\n	printf(\"EqJun << \");\n\n	//get eq\n	while ((temp = read_unit()) != 0)\n	{\n		to_eq->eqarr[length-20+i] = temp;\n		i++;\n		if (i == 20)\n		{\n			length += 20;\n#ifdef DEBUG\n			printf(\"call : realloc (%d : %s)\\n\", length, to_eq->eqarr);\n#endif\n			to_eq->eqarr = (Eq_unit_t *)realloc(to_eq->eqarr, sizeof(Eq_unit_t)*length);\n\n			i = 0;\n		}\n	}\n\n	//check Quit code\n	if (read_check_quit(*to_eq))\n	{\n		to_err->errcode = QUIT;\n	}\n}\n\nvoid eq_cal(Eq_t eq, Num_t *to_res, Err_t *to_err)\n{\n#ifdef DEBUG\n	printf(\"eq_cal\\n\");\n#endif\n\n	Bk_t brakets;\n	Eq_tokened_t token_eq = {&token_eq, &token_eq,};\n\n	//tokenizing\n#ifdef DEBUG\n	printf(\"call : cal_token_eq\\n\");\n#endif\n	cal_token_eq(eq, to_err, &token_eq);\n\n	//find brakets\n#ifdef DEBUG\n		printf(\"call : cal_braket_matching\\n\");\n#endif\n	cal_braket_matching(to_err, &brakets, &token_eq);\n\n	while (to_err->errcode == NORMAL_STATE && brakets.bkarr != NULL)\n	{\n		//Calculate all from inner braket to outer one\n		cal_with_brakets(to_res, to_err, &brakets, token_eq);\n	}\n}\n\nvoid eq_print(Eq_t eq, Num_t res, Err_t err)\n{\n	printf(\"%s\\n\",eq.eqarr);\n}\n" "Eqlib.c" nil nil nil nil nil nil)
                       ("Eqlib_helper.c" "#include \"Eqlib_helper.h\"\n#include <stdio.h>\n#include <stdlib.h>\n\n//eq_read helper\nstatic int inerr = 0;\n\nEq_unit_t read_unit(void)\n{\n	Eq_unit_t temp = 0;\n\n	temp = getchar();\n	switch (temp)\n	{\n		case EOF :\n				inerr = 1;\n				temp = 0;\n				break;\n		case '\\n' :\n				temp = 0;\n		default :\n				inerr = 0;\n				break;\n	}\n\n	return temp;\n}\n\nint read_check_quit(Eq_t eq)\n{\n	switch (strlen(eq.eqarr))\n	{\n		case 2 :\n				 return !strncmp(eq.eqarr,\"$q\", 2);\n		case 5 :\n				 return !strncmp(eq.eqarr,\"$quit\", 5);\n		default :\n				 return 0;\n	}\n}\n\n\n//eq_cal helper\nvoid cal_token_eq(Eq_t eq, Err_t *to_err, Eq_tokened_t *to_tok)\n{\n	int position = 0;\n	int length = 0;\n\n	while (*(eq.eqarr+position) != '\\0')\n	{\n		braket_set(eq.eqarr+position, to_tok, &length);\n		arith_set(eq.eqarr+position, to_tok, &length);\n		func_set(eq.eqarr+position, to_tok, &length);\n		braket_set(eq.eqarr+position, to_tok, &length);\n		if (length == 0)\n		{\n			to_err->errcode = ILLEGAL_CHARACTER;\n			to_err->char_num = position;\n		}\n		position += length;\n		length = 0;\n	}\n}\n\nvoid cal_braket_matching(Err_t *to_err, Bk_t *to_bk, Eq_tokened_t *to_tok)\n{\n	int position = 0;\n	Bk_t bk_stack = {NULL};\n\n	to_tok = to_tok->first;\n\n#ifdef DEBUG\n	printf(\"cal_braket_matching[before while]\\n\");\n#endif\n\n	while (to_tok != to_tok->last)\n	{\n#ifdef DEBUG\n		printf(\"cal_braket_matching[in while]\\n\");\n#endif\n		braket_check_from_first(to_bk, &bk_stack, to_tok, &position);\n		if (bk_stack.bkarr != NULL)\n		{\n#ifdef DEBUG\n			printf(\"cal_braket_matching[in while/in if]\\n\");\n#endif\n			switch (bk_stack.bkarr->kind)\n			{\n				case IL_BIG :\n						 to_err->errcode = NOT_MATCH_BIG_RIGHT;\n						 to_err->char_num = position;\n						 return;\n				case IL_MIDDLE :\n						 to_err->errcode = NOT_MATCH_MIDDLE_RIGHT;\n						 to_err->char_num = position;\n						 return;\n				case IL_SMALL :\n						 to_err->errcode = NOT_MATCH_SMALL_RIGHT;\n						 to_err->char_num = position;\n						 return;\n				default :\n						 break;\n			}\n		}\n	}\n	if (bk_stack.bkarr != NULL)\n	{\n#ifdef DEBUG\n		printf(\"cal_braket_matching[after while/in if]\\n\");\n#endif\n		switch (bk_stack.bkarr->kind)\n		{\n			case BIG :\n					 to_err->errcode = NOT_MATCH_BIG_LEFT;\n					 to_err->char_num = position;\n					 break;\n			case MIDDLE :\n					 to_err->errcode = NOT_MATCH_MIDDLE_LEFT;\n					 to_err->char_num = position;\n					 break;\n			case SMALL :\n					 to_err->errcode = NOT_MATCH_SMALL_LEFT;\n					 to_err->char_num = position;\n					 break;\n			default :\n					 break;\n		}\n	}\n}\n\nvoid cal_with_brakets(Num_t *to_res, Err_t *to_err, Bk_t *to_bk, Eq_tokened_t tok)\n{to_bk->bkarr = NULL;}\n" "Eqlib_helper.c" nil nil nil nil nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'src
                     '(("Arith.c" "#include \"Arith.h\"\n#include <string.h>\n\nvoid arith_set(Eq_unit_t *eq, Eq_tokened_t *to_tok, int *len)\n{\n	*len = strlen(eq);\n}\n" "Arith.c" nil nil nil nil nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'src
                     '(("Braket.c" "#include \"Braket.h\"\n\nvoid braket_set(Eq_unit_t *eq, Eq_tokened_t *to_tok, int *len)\n{}\n\nvoid braket_check_from_first(Bk_t *to_bk, Bk_t *bk_stack, Eq_tokened_t *to_tok, int *len)\n{}\n" "Braket.c" nil nil nil nil nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'src
                     '(("Func.c" "#include \"Func.h\"\n\nvoid func_set(Eq_unit_t *eq, Eq_tokened_t *to_tok, int *len)\n{}\n" "Func.c" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Wed May 13 15:43:58 2015
