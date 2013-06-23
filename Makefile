# The format of this file is based on GNU_Make_Makefile_templates
# https://github.com/Vdragon/GNU_Make_Makefile_templates
# 變數
# Variables
NAME_PROJECT = C_CPP_project_template
NAME_TARGET = Unix_x86_32bit_debug
POSTFIX_TYPE_SOURCE_CODE_C = c
POSTFIX_TYPE_SOURCE_CODE_CPP = cpp
POSTFIX_TYPE_HEADER_C = h
POSTFIX_TYPE_HEADER_CPP = hpp
POSTFIX_TYPE_OBJECT_CODE = object_code
POSTFIX_TYPE_EXECUTABLE = exe
COMPILER_C = gcc
COMPILER_CPP = g++
DIR_SOURCE_CODE = Source_code
DIR_OBJECT_CODE = Object_code
DIR_BUILD = Build
OPTION_GCC_WITH_DEBUGGING_SYMBOLS = -g
OPTION_GPP_WITH_DEBUGGING_SYMBOLS = ${OPTION_GCC_WITH_DEBUGGING_SYMBOLS}
OPTION_GCC_ONLY_COMPILE = -c
OPTION_GPP_ONLY_COMPILE = ${OPTION_GCC_ONLY_COMPILE}
OPTION_GCC_OUTPUT = -o
OPTION_GPP_OUTPUT = ${OPTION_GCC_OUTPUT}
OPTION_MKDIR_CREATE_PARENT_AUTOMATICALLY = --parent

# 主要內容
# Main content
## Generic build rules
### C/CPP source code
%.o : %.c
	${COMPILER_C} ${OPTION_GCC_ONLY_COMPILE} ${OPTION_GCC_OUTPUT} ${DIR_OBJECT_CODE}/${NAME_TARGET}/%.${NAME_TYPE_OBJECT_CODE} %.c
%.o : %.cpp
	${COMPILER_CPP} ${OPTION_GPP_ONLY_COMPILE} ${OPTION_GPP_OUTPUT} ${DIR_OBJECT_CODE}/${NAME_TARGET}/%.${NAME_TYPE_OBJECT_CODE} %.cpp

## Specific build rules
.PHONY : build
build : compile link

.PHONY : compile
compile : 
	mkdir ${OPTION_MKDIR_CREATE_PARENT_AUTOMATICALLY} ${DIR_OBJECT_CODE}/${NAME_TARGET}
	${COMPILER_CPP} ${OPTION_GCC_ONLY_COMPILE} ${DIR_SOURCE_CODE}/main.cpp ${OPTION_GPP_OUTPUT} ${DIR_OBJECT_CODE}/${NAME_TARGET}/main.o
	mkdir ${OPTION_MKDIR_CREATE_PARENT_AUTOMATICALLY} ${DIR_OBJECT_CODE}/${NAME_TARGET}/showSoftwareInfo
	${COMPILER_C} ${OPTION_GCC_ONLY_COMPILE} ${DIR_SOURCE_CODE}/showSoftwareInfo/showSoftwareInfo.c ${OPTION_GCC_OUTPUT} ${DIR_OBJECT_CODE}/${NAME_TARGET}/showSoftwareInfo/showSoftwareInfo.o
	mkdir ${OPTION_MKDIR_CREATE_PARENT_AUTOMATICALLY} ${DIR_OBJECT_CODE}/${NAME_TARGET}/pauseProgram
	${COMPILER_C} ${OPTION_GCC_ONLY_COMPILE} ${DIR_SOURCE_CODE}/pauseProgram/pauseProgram.c ${OPTION_GCC_OUTPUT} ${DIR_OBJECT_CODE}/${NAME_TARGET}/pauseProgram/pauseProgram.o

.PHONY : link
link : compile
	mkdir ${OPTION_MKDIR_CREATE_PARENT_AUTOMATICALLY} ${DIR_BUILD}/${NAME_TARGET}
	${COMPILER_CPP} ${OPTION_GPP_OUTPUT} ${DIR_BUILD}/${NAME_TARGET}/${NAME_PROJECT}.${NAME_TARGET}.${NAME_TYPE_EXECUTABLE} ${DIR_OBJECT_CODE}/${NAME_TARGET}/main.o ${DIR_OBJECT_CODE}/${NAME_TARGET}/pauseProgram/pauseProgram.o ${DIR_OBJECT_CODE}/${NAME_TARGET}/showSoftwareInfo/showSoftwareInfo.o
	
.PHONY : clean
clean :
	rm ${DIR_OBJECT_CODE}/${NAME_TARGET}/*.o

.PHONY : rename_project
rename_project : 
	sed --in-place=.backup 's/C_CPP_project_template/${NAME_PROJECT}/g' IDE_Eclipse_CDT/.*project
	mv IDE_Code__Blocks/C_CPP_project_template.cbp IDE_Code__Blocks/${NAME_PROJECT}.cbp
	sed --in-place=.backup 's/C_CPP_project_template/${NAME_PROJECT}/g' IDE_CodeLite/C_CPP_project_template.project
	mv IDE_CodeLite/C_CPP_project_template.project IDE_CodeLite/${NAME_PROJECT}.project

.PHONY : initialize
initialize : rename_project
	rm -rf .git .gitignore