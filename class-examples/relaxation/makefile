COMPILER= gfortran

FLAGS = -O3

EXEC = relaxation_example

SRC = $(wildcard *.f90) 

OBJ = $(SRC:.f90=.o)

$(EXEC): $(OBJ)
	$(COMPILER) $(FLAGS) -o $@ $^

types.o: types.f90
	$(COMPILER) $(FLAGS) -c $<

main.o: main.f90 types.o 
	$(COMPILER) $(FLAGS) -c $<

clean:
	rm -rf *.o *.mod

mrproper: clean
	rm -rf $(EXEC)
