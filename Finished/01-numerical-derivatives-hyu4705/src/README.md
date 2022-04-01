# Numerical Derivatives (Euler Method)

## What the program does?

This program will use the central difference method to compute both derivative and second derivative of function
f(x) = x * sin(x). And the program will return the result of second derivative with three different type of results.
Which are the second derivative value with accurate value, value by symmetric three point formula, value by symmetric five point formula as a data named 'results.dat'.

With the data, it will help drawing the graph of showing difference between three values (see how much error with two methods comparing to the accurate value), the error comparasion and error gap and so on.

To use the program, users only need to run the files then put the x_0 value which they except to see the result.

## compilation instructions

Tools requirement: Linux system, jupyter notebook.

Compile on the terminal of Linux system like ubuntu.

Open the terminal and go to the location where those files are.

	`$ cd ~/01-numerical-derivatives-hyu4705/src `

Then run the 'makefile' to create the `*.o *.mod` and exe files.

	`$ make`

And now the exe file 'derivatives' will show on the location, execute it

	`$ ./derivatives`

Now user need to put a number as a x_0 for the result of data. For example, type 3 and then press ENTER key.

Then the file 'results.dat' will shows up in the location, and now open the jupyter notebook to execute
the file 'plots_and_regression.ipynb' and then compile each lines of code where we have all data required from the 
'results.dat'

## What to expect from user

As the result, there will be increasing error (difference) as the increasing of h value we choose. But if the h value is too small, there will also exist some floating at the beginning. 

Between 3 point and 5 point formula, it's obvious they both have error but 5 point formula is more accurate than 5 point formula.

## How should the program work

The program relies on fortran language to code the formula and system required to run the program which returns a output of database including three values of second derivative and take those values into the code in jupyter notebook which is already prepared to draw the graph we expect.