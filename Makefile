FMOD = binio_fort.f90
CMOD = fileio2.cpp

#FC = ifort
FC = gfortran
CC = g++

ifeq (${FC}, ifort)
	FFLAG = -warn all -O3 -traceback -assume byterecl
else ifeq (${FC}, gfortran)
	FFLAG = -Wall -O3 -fbacktrace
endif

ifeq (${CC}, g++)
	CFLAG = -Wall -O3
endif

FOBJ = ${FMOD:.f90=.o}
COBJ = ${FMOD:.cpp=.o}

all : ${FOBJ} ${COBJ}

${FOBJ} : ${FMOD}
	${FC} -c $^ ${FFLAG}

${COBJ} : ${CMOD}
	${CC} -c $^ ${CFLAG}


.PHONY : clean re

clean : 
	rm -fv *.o *.mod

re : clean all

