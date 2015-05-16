# Complier Flags
#
CC = gcc
CFLAGS = -Wall
CFLAGS += $(strip $(INCPATH:%=-I%))

# Project files
#
ROOTPATH = "/home/junyoung/Study/ExtraStudy/Bloging/C_language/0507_Cal"
SRCORG != find -name "*.c"
SRC != find -name "*.c" | xargs basename -a
OBJ = $(SRC:%.c=%.o)
TAR = CalEqulator
DEP = $(SRC:%.c=%.d)
SRCPATH != find src -type d
INCPATH != find include -type d

# Debug setting
#
DBGDIR = debug
DBGTAR = $(DBGDIR)/$(TAR)
DBGOBJ = $(addprefix $(DBGDIR)/, $(OBJ))
DBGDEP = $(addprefix $(DBGDIR)/, $(DEP))
DBGCFLAGS = -g -O0 -DDEBUG
DBGINCFILE = find $(DBGDIR)/ -name "*.d"

# Release setting
#
RLSDIR = release
RLSTAR = $(RLSDIR)/$(TAR)
RLSOBJ = $(addprefix $(RLSDIR)/, $(OBJ))
RLSDEP = $(addprefix $(RLSDIR)/, $(DEP))
RLSCFLAGS = -O3 -DNDEBUG
RLSINCFILE = find $(RLSDIR)/ -name "*.d"

# Rule selecting
#
ifneq ($(findstring debug, $(MAKECMDGOALS)), )
SETV = DBG
else
ifneq ($(findstring dbg, $(MAKECMDGOALS)), )
SETV = DBG
else
SETV = RLS
endif
endif
SELDIR = $($(SETV)DIR)
SELTAR = $($(SETV)TAR)
SELOBJ = $($(SETV)OBJ)
SELDEP = $($(SETV)DEP)
SELCFLAGS = $($(SETV)CFLAGS)
ifeq ($(shell [ -d $(SELDIR) ] && echo e), e)
SELINCFILE != $($(SETV)INCFILE)
endif

# Make Configuration
#
.PHONY : all debug release clean cleanall prep rebuild sel \
dbg rls cl ca rb
vpath %.c $(SRCPATH) $(SELDIR)

# Default rule
#
all : release

# Debug rule
#
debug : prep sel prop

# Release rule
#
release : prep sel prop

# Selected rule
#
sel : $(SELDEP) $(SELTAR)

$(SELTAR) : $(SELOBJ)
	@$(CC) $(CFLAGS) $(SELCFLAGS) $^ -o $@
	@echo "\t$@"
	@echo "\t  from $^"
	@echo "\t*********************************************"
	@echo
	@echo "\t*********************************************"

$(SELDIR)/%.o : %.c
	@$(CC) -c $(CFLAGS) $(SELCFLAGS) $< -o $@
	@echo "\t$@"
	@echo "\t  from $<"
	@echo

$(SELDIR)/%.d : %.c
	@$(CC) -MM -c $(CFLAGS) $(SELCFLAGS) $< -MF $@ -MT "$(SELDIR)/$*.o"
	@echo "\t* There are some non existing depend files. *"
	@echo "\t*********************************************"
	@echo "\t  =====> $@"
	@echo "\t*********************************************"

# Other rule
#
prep : #preposition
	@cd
	@mkdir -p $(SELDIR)
	@echo "Trying to make $(SELDIR) directory"
	@echo
	@echo "Compile using $(CC)"
	@echo "FLAGS = $(CFLAGS) $(SELCFLAGS)"
	@echo "\t*********************************************"

prop : #proposition
	@cp $(SELTAR) .
	@echo "\t*         end of build procedure            *"
	@echo "\t*********************************************"

cleanall : clean
	@rm -r -f $(RLSDIR) $(DBGDIR)
	@echo "\tcleaning"
	@echo "\t  DIRECTORY : $(RLSDIR) $(DBGDIR)"

clean :
	@rm -f $(RLSTAR) $(RLSOBJ) $(DBGTAR) $(DBGOBJ) $(TAR)
	@find . -name "*~" | xargs rm -r -f
	@echo "\tcleaning"
	@echo "\t  *~files"
	@echo "\tcleaning"
	@echo "\t  TARGET : $(RLSTAR) $(DBGTAR) $(TAR)"
	@echo "\tcleaning"
	@echo "\t  OBJECT : $(RLSOBJ)"
	@echo "\t           $(DBGOBJ)"

rebuild : clean all

test : $(TAR)
	./$(TAR)

# Abbreviation of rules
#
dbg : debug
rls : release
cl : clean
ca : cleanall
rb : rebuild


# Include dependency
#
-include $(SELINCFILE)
