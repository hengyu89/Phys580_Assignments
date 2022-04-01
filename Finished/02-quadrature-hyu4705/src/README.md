# Neutron flux from a reactor. Quadrature Techniques

## What the program does?

This program will use both the bools and Monte Carlo methods to calculate the integration of a rectangular or a sphere and also the uncertainty value of the result.
The function is determined by the user and it requires to have some input values which will show up once the user runs the code.
Once use fills required values, it will create two .dat files as rectangular and sphere seperately. And those files could be used in the .ipynb file in jupyter notebook to graph the tendency of two methods the code is using.

## Compilation instructions

Tools requirement: Linux system, jupyter notebook.

Compile on the terminal of Linux system like ubuntu.

Open the terminal and go to the location where those files are. Then run the 'makefile' to create the `*.o *.mod` and exe files.

	'$ make'

And now the exe file 'nuclear-reactor' will show on the location, execute it

	`$ ./nuclear-reactor`

Now user need to put a number as the instruction leads. And here is the examples to use (which also can be seen in main.f90 file):

! Basic part of the project
! depth = 40.0_dp
! width = 100.0_dp
! height = 60.0_dp
! y_zero = 30.0_dp
! x_min = 5_dp
! x_max = 200.0_dp
! x_step = 5_dp
! n_grid = 25
! m_samples = 10000

! Advanced part of the project
! x_zero = 80.0_dp
! r_min = 1.0_dp
! r_max = 19.0_dp
! r_step = 1.0_dp

once the use put all necessary values, it will show "well done" and two new .dat files are created.

## What to expect from user

As the result, user is able to see the difference of results by booles and monte carlo methods with the graph and how much error will these two method creat.

## How should the program work 

The program relies on fortran language to code the formula and system required to run the program which returns a output of database including three values of second derivative and take those values into the code in jupyter notebook which is already prepared to draw the graph we expect.
