compiler = gfortran
flags = -O3 -pedantic -Wall
exec = hello_world

src = $(wildcard *.f90)
obj = $(src:.f90=.o)

all: $(exec)

$(exec): $(obj)
	$(compiler) $(flags) -o $@ $^

main.o: main.f90 input_output.o evaluator.o
	$(compiler) $(flags) -c $<

input_output.o: input_output.f90
	$(compiler) $(flags) -c $<

evaluator.o: evaluator.f90
	$(compiler) $(flags) -c $<

clean:
	rm -rf *.o *.mod

mrproper: clean
	rm -rf $(exec)