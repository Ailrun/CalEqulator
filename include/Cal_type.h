#ifndef CAL_TYPE_H_ //#ifndef CAL_TYPE_H_ start
#define CAL_TYPE_H_ //CAL_TYPE_H_ definition

#define NORMSTR 0x00000000 //Prefix constant for normal condition
#define COMPSTR 0x00010000 //Prefix constant for computational error
#define MATHSTR 0x00020000 //Prefix constant for mathematical error
#define EDITSTR 0x00040000 //Prefix constant for linguistic error

/*
#define NORMAL_STATE PRE_NORM+0x0
#define OVERFLOW PRE_COMP+0x0
#define DIVIDE_ZERO PRE_MATH+0x0
#define NEGTIVE_SQRT PRE_MATH+0x1
#define NOT_NUMBER PRE_EDIT+0x1
#define NOT_MATCH_BIG_LEFT PRE_EDIT+0x2
#define NOT_MATCH_BIG_RIGHT PRE_EDIT+0x3
#define NOT_MATCH_MIDDLE_LEFT PRE_EDIT+0x4
#define NOT_MATCH_MIDDLE_RIGHT PRE_EDIT+0x5
#define NOT_MATCH_SMALL_LEFT PRE_EDIT+0x6
#define NOT_MATCH_SMALL_RIGHT PRE_EDIT+0x7
#define QUIT 0xFFFFFFFF
*/

typedef enum Errcode_t
{
	NORMAL_STATE = NORMSTR, //NORMAL

	OVERFLOW = COMPSTR, //

	DIVIDE_ZERO = MATHSTR, NEGATIVE_SQRT,

	ILLEGAL_CHARACTER = EDITSTR, NOT_MATCH_BIG_LEFT, NOT_MATCH_BIG_RIGHT,
	NOT_MATCH_MIDDLE_LEFT, NOT_MATCH_MIDDLE_RIGHT, NOT_MATCH_SMALL_LEFT,
	NOT_MATCH_SMALL_RIGHT,

	QUIT = 0xFFFFFFFF
} Errcode_t;

typedef struct Err_t
{
	Errcode_t errcode;
	int line_num;
	int char_num;
} Err_t;

typedef char Eq_unit_t;
typedef struct Eq_t
{
	Eq_unit_t *eqarr;
} Eq_t;
typedef double Num_t;

#endif //#ifndef CAL_TYPE_H_ end
