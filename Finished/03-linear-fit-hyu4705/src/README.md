# Neutron flux from a reactor. Quadrature Techniques

## What the program does?

This program will draw the difference of Binding Energies with position of Protons or Neutrons, graph of uncertainties and positions of the stable isotopes and neutron dripline. The program will read the data file including the number of protons and neutrons, binding and uncertainties. Then use the basic function of linear algebra for the calculation for getting the parameter terms of Binding Energy function. 

## Compilation instructions

Tools requirement: Linux system, jupyter notebook.

Compile on the terminal of Linux system like ubuntu.

Once the data file is ready, type 'make' in the terminal for compiling the fortran code, then you will see the execute file 'nuclear_energies' in the direction, Once you active the file and type the name of data files required, then the program will provide both "results.dat" and "results_advanced.dat" data files for using into the jupyter notebook file to draw the graph the program desires.

## What to expect from user

Requirement of Data File: Write the length of data numbers at the beginning of file.
						  Number of Protons: column of 5
						  Number of Neutrons: Column of 4
						  Binding Energy: column of 6
						  Uncertainties: column of 8

## How should the program work 

The program relies on fortran language to code the formula and system required to run the program which returns the output of two databases including Binding energy and uncertainties with both theoretical values from calculation and experimental values from database the user has. and the other database with the positions of the stable isotopes and neutron dripline.
