COMPILER= gfortran

FLAGS = -O3 -fopenmp

EXEC = open_mp_example

SRC = $(wildcard *.f90) 

OBJ = $(SRC:.f90=.o)

$(EXEC): $(OBJ)
	$(COMPILER) $(FLAGS) -o $@ $^

types.o: types.f90
	$(COMPILER) $(FLAGS) -c $<

fourier.o: fourier.f90 types.o
	$(COMPILER) $(FLAGS) -c $<

monte_carlo.o: monte_carlo.f90 types.o
	$(COMPILER) $(FLAGS) -c $<

main.o: main.f90 types.o fourier.o monte_carlo.o
	$(COMPILER) $(FLAGS) -c $<

clean:
	rm -rf *.o *.mod

mrproper: clean
	rm -rf $(EXEC)
