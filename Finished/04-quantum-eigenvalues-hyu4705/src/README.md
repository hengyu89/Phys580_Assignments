# Solving Schrödinger Equation with Eigenvalues

## What the program does?

Start with the one dimensional Schrödinger Equation, the program will find the eigenenergies and eigenfunctions for the Hamiltonian parts and Woods Saxon potential.
Then save those databases into the .dat file separately and draw the graph for the comparison with ground and first two excited states coded in jupyter notebook.

With this program, users will be more familiar with the one demensional Schrödinger Equation and understand the posibillity of those energies states in the box (infinite well)

## Compilation instructions

Tools requirement: Linux system, fortran, jupyter notebook.
Compile on the terminal of Linux system like ubuntu.

Open the terminal and go to the location where those files are and enter `make` to execute the program. Then the direction will occur the executeable file name ***woods_saxon***.
Then excute it with `./woods_saxon`, the program will ask the user to type the excepted n_points n, length L and radius R. Which represents the number of slices of the box n, the half length of the box L and radius of Woods Saxon Potential R. where the empty type and string are not accepted and the warning will occur if so.
Recommend example input: `length = 20._dp`, `n_points = 400`, and `radius = 2.0_dp`

## What to expect from user.

As the result, user will be able to know the method and basic way to show the integral, hamiltonian and Woods Saxon. And the typical posibillity of particles will be in the box with three lowest state energies.

## How should the program work.

The program relies on fortran language to code the formula and system required to run the program which returns a output of database including three values of second derivative and take those values into the code in jupyter notebook which is already prepared to draw the graph we except.