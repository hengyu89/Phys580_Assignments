# Solving Schrödinger Equation with Eigenvalues

## Important Considerations

### Set up and submission

Starting with this project we will no longer use the GitHub work-flow. You can
work directly in the `master` branch and commit into it.

If you have significant problems with your code you can raise an issue so that
I cant take a look. However if your code is clearly 'buggy' and it does not
compile due to syntax errors I will not provide feedback.

If you're getting compilation errors that you don't really understand we can
take a look together during office hours or class.

Don't forget to push your final commit before the submission deadline so that
I can take a look at your code.

## Assignment

We want to find ***numerical*** solutions to the one dimensional Schrödinger equation

$$ \left( - \frac{\hbar^2}{2 m} \frac{d^2}{dx^2} + V(x) \right) \Psi(x) = E \Psi(x), $$

for different potentials. 

### General overview

We will discretize the wavefunction $\Psi$ on a lattice, turning it into a
column vector. On the same lattice, the potential energy will be a diagonal
matrix, while the kinetic energy will be a tridiagonal matrix. Therefore the
Hamiltonian will be another tridiagonal matrix. We can then use the `lapack`
library to find the eigenvalues (energies) and eigenvectors (wavefunctions).
If you can't install `lapack` on your system you can use the `tqli` and
`eigsrt` subroutines provided in the starter code (more on that below).

Your ultimate goal is to find the eigenenergies and eigenfunctions for the
Woods Saxon potential

$$ V(x) = \frac{-V_0}{1 + \exp ((|x|-R)/a)} $$

where $V_0$ is the potential's depth, $R$ is the radius, and $a$ is the
surface thickness. For simplicity, let $\hbar = 197.3$MeV fm (let $c =1$), let
the mass $m = 939$MeV (technically $m =939$ MeV/c$^2$, but as $c=1$ mass and
energy have the same type of units), let $V_0 = 50$MeV and $a=0.2$fm which are
typical values (1 fm (or fermi) = $10^{-15}$m). In the spirit of good coding
practice you should define these as private `parameter` in the
appropriate module or subroutine.

Your wavefunction will be discretized in a “box” from `–L` to `+L`, with `N`
points and  a step size `dx = (2L)/(N-1)`. Hence the sampled points for x will
be `x(i) = -L + dx*(i-1)`.

Your Hamiltonian will be a tridiagonal matrix with two parts. The potential
energy is easy, it is just diagonal, `V(i) = V(x)` with `x(i) = -L + dx*(i-1)`.

The kinetic energy is slightly subtler, but not much. Remember that it is $ -
\frac{\hbar^2}{2 m} \frac{d^2}{dx^2} \Psi(x)$, and on a lattice of equally
spaced points we can discretize the second derivate with a symmetric
three-point formula: $(\Psi(x-dx) + \Psi(x+dx) - 2\Psi(x))/dx^2$. Hence the kinetic
energy contributes to the diagonal a constant `+hbar**2/mass/dx**2` and along
the off-diagonal also a constant `-0.5*hbar**2/mass/dx**2`.

Adding the potential and kinetic energy matrices and you have a discretized
representation of the Hamiltonian. 

Your program should ask the user to input
1. The size of the box, $L$, that is, from $-L$ to $+L$. You input the value of $L$.
2. The number of points, $N$, on your lattice. You should check that above certain value your results are not sensitive to the choice of $N$. 
3. The radius of the Woods Saxon potential $R$.
You can hard-code $\hbar$, $m$, $V_0$ and $a$ as `parameter` in the appropriate 
module, subroutine or function.

You can ***and should*** use the functions to read positive non zero reals
and integers that you've written for previous assignments

Typical values to test your program can be `length = 20._dp`, `n_points =
400`, and `radius=2.0_dp`, but be sure to test that your results don't change
to much if you slightly change your input values.

### First part. Infinite well (worth 30%)

1. Write a subroutine that samples the $x$ coordinate as indicated above and
stores those points in an array

2. Write a subroutine to solve the Infinite well problem (AKA particle in a box),
that is $V(x)=0$. This subroutine should do the following:
	1. call a subroutine to construct the kinetic energy diagonal and off-diagonal terms.
	2. call a subroutine that given those terms returns the eigenvalues and eigenvectors. (when debugging, check that the eigenvalues are ordered in ascending order)
	3. call a subroutine that normalizes the eigen-wavefunctions (i. e. multiply the wavefunction by the constant that makes $\int_{-L}^L \Psi(x)^2 dx = 1 $)
	4. returns in an array the 3 lowest energies and in another array the 3 corresponding wave functions.

Your eigenfunctions should look like cosine and sine functions

4. Write a subroutine to calculate analytically the three lowest energies for the
particle in a box. In this cases the energies are given by
$$ E_i = i^2 \frac{\hbar^2 \pi^2}{8mL^2}. $$

5. Write a subroutine that prints to screen the analytic and numerical solutions.

It is fine if your analytic and numerical energies are not exactly the same.
After all we're just using a first order approximation for the second
derivative in the kinetic energy. The difference should be in the second or
third decimal point

6. Write a subroutine that writes in a file the sample points $x$, and the three
normalized probability densities (i.e. $\Psi(x)^2$)

### Second part. Harmonic oscillator (worth 20%)

1. Write a subroutine to solve the Harmonic Oscillator problem, that is $V(x)=\frac{\hbar^2}{2m} x^2$.
This subroutine should do the following:
	1. call a subroutine to construct the kinetic energy diagonal and off-diagonal terms.
	2. call a subroutine to construct the harmonic oscillator potential diagonal terms
	2. call a subroutine that given diagonal and off-diagonal terms of the Hamiltonian returns the eigenvalues and eigenvectors.
	3. call a subroutine that normalizes the eigen-wavefunctions 
	4. returns in an array the 3 lowest energies and in another array the 3 corresponding wave functions.

Your eigenfunctions should look like Gaussian functions

2. Write a subroutine to calculate analytically the three lowest energies for the
harmonic oscillator. In this cases the energies are given by
$$ E_i = \left(i - \frac{1}{2} \right)\hbar^2/m. $$

3. Call a subroutine that prints to screen the analytic and numerical solutions.

Again, it is fine if your analytic and numerical energies are not exactly the same.
The difference should be in the first or second decimal point

4. Call a subroutine that writes in a file the sample points $x$, and the three
normalized probability densities (i.e. $\Psi(x)^2$)

### Third part. Woods-Saxon I (worth 20%)

1. Write a subroutine to solve the Woods-Saxon, that is $V(x) = \frac{-V_0}{1 + \exp ((|x|-R)/a)}$.
This subroutine should do the following:
	1. call a subroutine to construct the kinetic energy diagonal and off-diagonal terms.
	2. call a subroutine to construct the Woods-Saxon potential diagonal terms
	2. call a subroutine that given diagonal and off-diagonal terms of the Hamiltonian returns the eigenvalues and eigenvectors.
	3. call a subroutine that normalizes the eigen-wavefunctions
	4. returns in an array the 3 lowest energies and in another array the 3 corresponding wave functions.

2. Call a subroutine that writes in a file the sample points $x$, and the three
normalized probability densities (i.e. $\Psi(x)^2$)

### Fourth part. Woods-Saxon II (worth 20%)

1. Write a subroutine that writes in a file the 3 lowest energies of the
Woods-Saxon potential as a function of $R$, going from 2 to 10.

### Final part. Plotting your results (worth 10%)

Create a jupyter notebook to plot your results. You should have 4 different
plots. Don't forget to indicate the units in all your plots

1. The ground state normalized probability density for the 3 different problems 
2. The 1st excited state normalized probability density for the 3 different problems 
3. The 2nd excited state normalized probability density for the 3 different problems 
4. The three lowest energies for the Woods-Saxon potential as a function of the radius $R$


## General Notes

### Eigen Solvers

Whether you use `lapack` or the modified numerical recipes subroutines
provided in the starter code make sure to read the corresponding
documentation. Since the arguments in each case are actually different.

The documentation for lapack's `dstev` can be found
[here](http://www.netlib.org/lapack/explore-html/dc/dd2/group__double_o_t_h_e_reigen_gaaa6df51cfd92c4ab08d41a54bf05c3ab.html)

The documentation of `tqli` and `eigsrt` is provided as block comment in the starter code.

### Normalizing your wavefunctions

A good way to check your normalization subroutine during your debugging stage
is to call it twice. If your subroutine works correctly the wavefunction
should not change the second time you call it (since it's already normalized)

Also, when you plot the ground state for the particle in a box it should be
clear that the integral is 1.

### Final notes

As usual, for full credit on all parts, your program should be well-commented,
and input and output clear and easy to use with an informative `README.md` in
your `src/` directory.