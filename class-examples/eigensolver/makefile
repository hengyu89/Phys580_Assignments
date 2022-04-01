COMPILER= gfortran

FLAGS = -O3

LINEAR_ALGEBRA = -llapack #-lblas

EXEC = lapack_example

SRC = $(wildcard *.f90) 

OBJ = $(SRC:.f90=.o)

$(EXEC): $(OBJ)
	$(COMPILER) $(FLAGS) -o $@ $^ $(LINEAR_ALGEBRA)

types.o: types.f90
	$(COMPILER) $(FLAGS) -c $<

eigensolver.o: eigensolver.f90 types.o
	$(COMPILER) $(FLAGS) -c $<

main.o: main.f90 types.o eigensolver.o
	$(COMPILER) $(FLAGS) -c $<

clean:
	rm -rf *.o *.mod

mrproper: clean
	rm -rf $(EXEC)
