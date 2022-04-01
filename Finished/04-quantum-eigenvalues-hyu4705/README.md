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

<p align="center"><img src="/tex/054c6a538901fafcf642b0f7b48aa019.svg?invert_in_darkmode&sanitize=true" align=middle width=260.6055045pt height=40.11819404999999pt/></p>

for different potentials. 

### General overview

We will discretize the wavefunction <img src="/tex/535b15667b86f1b118010d4c218fecb9.svg?invert_in_darkmode&sanitize=true" align=middle width=12.785434199999989pt height=22.465723500000017pt/> on a lattice, turning it into a
column vector. On the same lattice, the potential energy will be a diagonal
matrix, while the kinetic energy will be a tridiagonal matrix. Therefore the
Hamiltonian will be another tridiagonal matrix. We can then use the `lapack`
library to find the eigenvalues (energies) and eigenvectors (wavefunctions).
If you can't install `lapack` on your system you can use the `tqli` and
`eigsrt` subroutines provided in the starter code (more on that below).

Your ultimate goal is to find the eigenenergies and eigenfunctions for the
Woods Saxon potential

<p align="center"><img src="/tex/8355156bca5e02c2b790b4a34942921f.svg?invert_in_darkmode&sanitize=true" align=middle width=206.4436275pt height=37.73900955pt/></p>

where <img src="/tex/6fb5260e74022b7ffdfd88d2abafa518.svg?invert_in_darkmode&sanitize=true" align=middle width=16.141598549999987pt height=22.465723500000017pt/> is the potential's depth, <img src="/tex/1e438235ef9ec72fc51ac5025516017c.svg?invert_in_darkmode&sanitize=true" align=middle width=12.60847334999999pt height=22.465723500000017pt/> is the radius, and <img src="/tex/44bc9d542a92714cac84e01cbbb7fd61.svg?invert_in_darkmode&sanitize=true" align=middle width=8.68915409999999pt height=14.15524440000002pt/> is the
surface thickness. For simplicity, let <img src="/tex/d31bb66d0a527a7ee36af7dac0586e61.svg?invert_in_darkmode&sanitize=true" align=middle width=68.24201339999998pt height=22.648391699999998pt/>MeV fm (let <img src="/tex/269ffb69691b5479db169a4fc35d4b9f.svg?invert_in_darkmode&sanitize=true" align=middle width=37.25064419999999pt height=21.18721440000001pt/>), let
the mass <img src="/tex/bb269ac4be3abdce4b19f1adddf48549.svg?invert_in_darkmode&sanitize=true" align=middle width=61.00835894999999pt height=21.18721440000001pt/>MeV (technically <img src="/tex/10018c387229ee9cd61b41559d79f311.svg?invert_in_darkmode&sanitize=true" align=middle width=61.00835894999999pt height=21.18721440000001pt/> MeV/c<img src="/tex/e18b24c87a7c52fd294215d16b42a437.svg?invert_in_darkmode&sanitize=true" align=middle width=6.5525476499999895pt height=26.76175259999998pt/>, but as <img src="/tex/2a24f4b966bec8b31d29ed41eb258910.svg?invert_in_darkmode&sanitize=true" align=middle width=37.25064419999999pt height=21.18721440000001pt/> mass and
energy have the same type of units), let <img src="/tex/8dbdb184ace2183ddadcbfddcdaab66c.svg?invert_in_darkmode&sanitize=true" align=middle width=55.319561549999996pt height=22.465723500000017pt/>MeV and <img src="/tex/62ccc3a28d9f6a634ece9e8fc12e4c3e.svg?invert_in_darkmode&sanitize=true" align=middle width=51.611427449999994pt height=21.18721440000001pt/>fm which are
typical values (1 fm (or fermi) = <img src="/tex/ee8b1ac4ea1abcfe3e3b422d14f40488.svg?invert_in_darkmode&sanitize=true" align=middle width=39.81753434999999pt height=26.76175259999998pt/>m). In the spirit of good coding
practice you should define these as private `parameter` in the
appropriate module or subroutine.

Your wavefunction will be discretized in a “box” from `–L` to `+L`, with `N`
points and  a step size `dx = (2L)/(N-1)`. Hence the sampled points for x will
be `x(i) = -L + dx*(i-1)`.

Your Hamiltonian will be a tridiagonal matrix with two parts. The potential
energy is easy, it is just diagonal, `V(i) = V(x)` with `x(i) = -L + dx*(i-1)`.

The kinetic energy is slightly subtler, but not much. Remember that it is <img src="/tex/e72fb7bb3f922789338b5ecbdef00cfc.svg?invert_in_darkmode&sanitize=true" align=middle width=94.5721095pt height=33.45973289999998pt/>, and on a lattice of equally
spaced points we can discretize the second derivate with a symmetric
three-point formula: <img src="/tex/f8a1c1d47d160967ac2360ab3c5bc4c8.svg?invert_in_darkmode&sanitize=true" align=middle width=274.89158234999996pt height=26.76175259999998pt/>. Hence the kinetic
energy contributes to the diagonal a constant `+hbar**2/mass/dx**2` and along
the off-diagonal also a constant `-0.5*hbar**2/mass/dx**2`.

Adding the potential and kinetic energy matrices and you have a discretized
representation of the Hamiltonian. 

Your program should ask the user to input
1. The size of the box, <img src="/tex/ddcb483302ed36a59286424aa5e0be17.svg?invert_in_darkmode&sanitize=true" align=middle width=11.18724254999999pt height=22.465723500000017pt/>, that is, from <img src="/tex/eec9b529b17d9357a71c7cba13cdbe4a.svg?invert_in_darkmode&sanitize=true" align=middle width=23.97267674999999pt height=22.465723500000017pt/> to <img src="/tex/02796cfe39b1df59d9d5303bb19ae6d4.svg?invert_in_darkmode&sanitize=true" align=middle width=23.97267674999999pt height=22.465723500000017pt/>. You input the value of <img src="/tex/ddcb483302ed36a59286424aa5e0be17.svg?invert_in_darkmode&sanitize=true" align=middle width=11.18724254999999pt height=22.465723500000017pt/>.
2. The number of points, <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/>, on your lattice. You should check that above certain value your results are not sensitive to the choice of <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/>. 
3. The radius of the Woods Saxon potential <img src="/tex/1e438235ef9ec72fc51ac5025516017c.svg?invert_in_darkmode&sanitize=true" align=middle width=12.60847334999999pt height=22.465723500000017pt/>.
You can hard-code <img src="/tex/89f88fd5e2d6e726d71a194719cacbce.svg?invert_in_darkmode&sanitize=true" align=middle width=8.881321349999991pt height=22.648391699999998pt/>, <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/>, <img src="/tex/6fb5260e74022b7ffdfd88d2abafa518.svg?invert_in_darkmode&sanitize=true" align=middle width=16.141598549999987pt height=22.465723500000017pt/> and <img src="/tex/44bc9d542a92714cac84e01cbbb7fd61.svg?invert_in_darkmode&sanitize=true" align=middle width=8.68915409999999pt height=14.15524440000002pt/> as `parameter` in the appropriate 
module, subroutine or function.

You can ***and should*** use the functions to read positive non zero reals
and integers that you've written for previous assignments

Typical values to test your program can be `length = 20._dp`, `n_points =
400`, and `radius=2.0_dp`, but be sure to test that your results don't change
to much if you slightly change your input values.

### First part. Infinite well (worth 30%)

1. Write a subroutine that samples the <img src="/tex/332cc365a4987aacce0ead01b8bdcc0b.svg?invert_in_darkmode&sanitize=true" align=middle width=9.39498779999999pt height=14.15524440000002pt/> coordinate as indicated above and
stores those points in an array

2. Write a subroutine to solve the Infinite well problem (AKA particle in a box),
that is <img src="/tex/81c1f5ad979fe28bec224efee14742c7.svg?invert_in_darkmode&sanitize=true" align=middle width=65.5592916pt height=24.65753399999998pt/>. This subroutine should do the following:
	1. call a subroutine to construct the kinetic energy diagonal and off-diagonal terms.
	2. call a subroutine that given those terms returns the eigenvalues and eigenvectors. (when debugging, check that the eigenvalues are ordered in ascending order)
	3. call a subroutine that normalizes the eigen-wavefunctions (i. e. multiply the wavefunction by the constant that makes <img src="/tex/54f2312933953bf77a297e249ad69d6f.svg?invert_in_darkmode&sanitize=true" align=middle width=121.04456924999998pt height=34.0824495pt/>)
	4. returns in an array the 3 lowest energies and in another array the 3 corresponding wave functions.

Your eigenfunctions should look like cosine and sine functions

4. Write a subroutine to calculate analytically the three lowest energies for the
particle in a box. In this cases the energies are given by
<p align="center"><img src="/tex/0ce6560583ba3b1af00c79f559b85de8.svg?invert_in_darkmode&sanitize=true" align=middle width=102.28825859999999pt height=35.77743345pt/></p>

5. Write a subroutine that prints to screen the analytic and numerical solutions.

It is fine if your analytic and numerical energies are not exactly the same.
After all we're just using a first order approximation for the second
derivative in the kinetic energy. The difference should be in the second or
third decimal point

6. Write a subroutine that writes in a file the sample points <img src="/tex/332cc365a4987aacce0ead01b8bdcc0b.svg?invert_in_darkmode&sanitize=true" align=middle width=9.39498779999999pt height=14.15524440000002pt/>, and the three
normalized probability densities (i.e. <img src="/tex/605f40c69b1e530d35815a15fd82cef7.svg?invert_in_darkmode&sanitize=true" align=middle width=41.51840219999998pt height=26.76175259999998pt/>)

### Second part. Harmonic oscillator (worth 20%)

1. Write a subroutine to solve the Harmonic Oscillator problem, that is <img src="/tex/ad3b56ed065c54407f0808eadaa74d63.svg?invert_in_darkmode&sanitize=true" align=middle width=95.45020154999999pt height=33.45973289999998pt/>.
This subroutine should do the following:
	1. call a subroutine to construct the kinetic energy diagonal and off-diagonal terms.
	2. call a subroutine to construct the harmonic oscillator potential diagonal terms
	2. call a subroutine that given diagonal and off-diagonal terms of the Hamiltonian returns the eigenvalues and eigenvectors.
	3. call a subroutine that normalizes the eigen-wavefunctions 
	4. returns in an array the 3 lowest energies and in another array the 3 corresponding wave functions.

Your eigenfunctions should look like Gaussian functions

2. Write a subroutine to calculate analytically the three lowest energies for the
harmonic oscillator. In this cases the energies are given by
<p align="center"><img src="/tex/46171ec8ca6d02ef277e160714b2f8e3.svg?invert_in_darkmode&sanitize=true" align=middle width=147.85895519999997pt height=39.452455349999994pt/></p>

3. Call a subroutine that prints to screen the analytic and numerical solutions.

Again, it is fine if your analytic and numerical energies are not exactly the same.
The difference should be in the first or second decimal point

4. Call a subroutine that writes in a file the sample points <img src="/tex/332cc365a4987aacce0ead01b8bdcc0b.svg?invert_in_darkmode&sanitize=true" align=middle width=9.39498779999999pt height=14.15524440000002pt/>, and the three
normalized probability densities (i.e. <img src="/tex/605f40c69b1e530d35815a15fd82cef7.svg?invert_in_darkmode&sanitize=true" align=middle width=41.51840219999998pt height=26.76175259999998pt/>)

### Third part. Woods-Saxon I (worth 20%)

1. Write a subroutine to solve the Woods-Saxon, that is <img src="/tex/d7f0d6402714984199648a3473e0c7f3.svg?invert_in_darkmode&sanitize=true" align=middle width=165.88021725pt height=29.205422400000014pt/>.
This subroutine should do the following:
	1. call a subroutine to construct the kinetic energy diagonal and off-diagonal terms.
	2. call a subroutine to construct the Woods-Saxon potential diagonal terms
	2. call a subroutine that given diagonal and off-diagonal terms of the Hamiltonian returns the eigenvalues and eigenvectors.
	3. call a subroutine that normalizes the eigen-wavefunctions
	4. returns in an array the 3 lowest energies and in another array the 3 corresponding wave functions.

2. Call a subroutine that writes in a file the sample points <img src="/tex/332cc365a4987aacce0ead01b8bdcc0b.svg?invert_in_darkmode&sanitize=true" align=middle width=9.39498779999999pt height=14.15524440000002pt/>, and the three
normalized probability densities (i.e. <img src="/tex/605f40c69b1e530d35815a15fd82cef7.svg?invert_in_darkmode&sanitize=true" align=middle width=41.51840219999998pt height=26.76175259999998pt/>)

### Fourth part. Woods-Saxon II (worth 20%)

1. Write a subroutine that writes in a file the 3 lowest energies of the
Woods-Saxon potential as a function of <img src="/tex/1e438235ef9ec72fc51ac5025516017c.svg?invert_in_darkmode&sanitize=true" align=middle width=12.60847334999999pt height=22.465723500000017pt/>, going from 2 to 10.

### Final part. Plotting your results (worth 10%)

Create a jupyter notebook to plot your results. You should have 4 different
plots. Don't forget to indicate the units in all your plots

1. The ground state normalized probability density for the 3 different problems 
2. The 1st excited state normalized probability density for the 3 different problems 
3. The 2nd excited state normalized probability density for the 3 different problems 
4. The three lowest energies for the Woods-Saxon potential as a function of the radius <img src="/tex/1e438235ef9ec72fc51ac5025516017c.svg?invert_in_darkmode&sanitize=true" align=middle width=12.60847334999999pt height=22.465723500000017pt/>


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