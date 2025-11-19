.SUFFIXES:
.SUFFIXES: .o .f90 .mod

FC = gfortran
O = -O3

OBJ=main.o
MOD=main.f90
EXE=main
LIB=-llapack -lblas

#the real program

main: $(MOD) $(OBJ)
				$(FC) $O -o $(EXE) $(OBJ) $(LIB)

#The module file

.f90.mod: # if there is no MOD object in line main:, it comes here and generate it
	$(FC) $(O) -c $*.f90 2>&1 | tee $*.TMPmod
.f90.o: $(MOD) 
	$(FC) $(O) -c $*.f90 2>&1 | tee $*.TMPl
clean:
	-(rm VERSION.h *.mod *.o *TMP*)