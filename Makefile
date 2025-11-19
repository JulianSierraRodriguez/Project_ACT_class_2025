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
# These are rules, they tell what file we want to create (target (.o or .mod)), it comes here when there is something missing or out of date.
##############
# command: prerequisites
#   command to build target
##############

.f90.mod: # we want to create a modfile, it does not need anything but the f90
	$(FC) $(O) -c $*.f90 2>&1 | tee $*.TMPmod
# the .mod file has the functions names and arguments for the compiler to work, in this case is a temporal  interface for modulus
.f90.o: $(MOD) # we want to create a objectfile, it need the mod file
	$(FC) $(O) -c $*.f90 2>&1 | tee $*.TMPl
#the .o file is needed for linking to the executable. 
## linking --- The linker combines all .o files plus any required libraries (like LAPACK, BLAS, Fortran runtime) into one executable file.


#if you use:
############### make clean
# you clean the VERSION.h file, all .mod, all .o, and all TMP (temporal) files.
clean:
	-(rm VERSION.h *.mod *.o *TMP*)