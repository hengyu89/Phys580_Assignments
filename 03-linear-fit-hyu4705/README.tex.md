# Linear leat-squared fit: Nuclear binding energies and drip-lines

## Important Considerations

### Set up and submission

We will continue using the GitHub work-flow as we did for the previous
assignment. That is

* Clone the repository on your local machine
* Create a new branch
* Commit and push your changes as you make progress
* Once you're ready for submission use the pull request feature to submit

Look at the README in assignment 01 for details on how to do this.

For the first three projects I will use the pull request feature to provide
you with detailed feedback.  **Note that this is *not* a license to submit an
incomplete project**. If you submit a project without graphs, you will not get
credit for submitting a 'final' graph. If your code is not working, your final
grade will reflect that fact. The purpose of feedback is to give you
guidance on how the code should interact with the user and to improve your
plots, not give you more time to submit them.

## Assignment

You have just been awarded a NASA grant to investigate stellar
nucleosynthesis. Among the most important inputs into nucleosynthesis are
nuclear binding energies. The binding energy of a nucleus is the amount of
energy released when a nucleus is formed from its constituent protons and
neutrons, or conversely how much energy could be released if a nucleus were
totally disassembled. For a nucleus with Z protons and N neutrons, we define 

$$ m(Z,N) c^2 = Z m_p c^2 + N m_n c^2 + BE(Z,N) $$

where $m(Z,N)$ is the mass of the nucleus, $m_p$ is the mass of the proton,
$m_n$ is the mass of the neutron, $c$ is the speed of light and $BE(Z,N)$ is
the binding energy.

Although the binding energy has been measured experimentally for thousands of
nuclei, an even larger number of short-lived isotopes exist whose binding
energies are unknown and difficult if not impossible to measure, yet are very
important to describe different nucleosynthesis processes. Of particular
interest are the binding energies of  heavy neutron-rich nuclei and the
position of the neutron drip-line. Using the binding energy we can compute the
neutron and proton separation energies which is the energy needed to separate
a neutron or a proton from its nucleus; the drip-lines bound the regions with
positive separation energies, that is, it takes energy to remove a proton or
neutron. Beyond the drip-lines the separation energies are negative, meaning
it requires no energy for a proton or neutron to just "drip off".)

Fortunately, we can estimate the location of the drip-lines by using the
*semi-empirical mass formula*:

$$
	BE(Z,N) = c_{\rm vol} A + c_{\rm surf} A^{2/3} + c_{\rm asym} \frac{(N-Z)^2}{A} + c_{\rm Coul} \frac{Z(Z-1)}{A^{1/3}} + c_{\rm pair} A^{-3/4} \delta(Z,N)
$$

where $A=Z+N$ is the *mass number*, and $\delta(Z,N) = 1$ if $Z$ and $N$ are
both even, $=-1$ if $Z$ and $N$ are both odd, and $=0$ if $A$ is odd.

The Atomic Mass Evaluation (AME) has compiled the most up to date value of all
measured binding energies. You can find them in the `EXPERIMENT_AME2016.dat`
file. The goal in this assignment is to determine the parameters $c_{\rm
vol}$, $c_{\rm surf}$, etc that best describe the experimental data and use
those parameters to identify the position of the neutron dripline.

### Basic Project: Best parameters (worth 60%)

As we saw in class, the best fit parameters from the linear model (like the
semi-empirical mass formula above) can be determined by solving a set of
linear equations, which in turn can be represented as a matrix equation

$$
	\alpha \cdot \vec{x} = \vec{\beta}
$$
$$
	\alpha_{ij} = \sum_{k=1}^{M} { \frac{f_i(Z_k,N_k) f_j(Z_k,N_k)}{\sigma_k^2}}
$$
$$
	\beta_i = \sum_{k=1}^{M} { \frac{f_i(Z_k,N_k) BE_{\rm exp}(Z_k,N_k)}{\sigma_k^2}}
$$

where $\vec{x}$ contains the parameters in the linear model, $\alpha_{ij}$ are
the matrix elements of $\alpha$, $\beta_i$ are the elements of the vector
$\vec{\beta}$, $M$ is the number experimental values, the functions
$f_i(Z_k,N_k)$ are the ones multiplying each of the linear parameters in the
semi-empirical mass formula, $BE_{\rm exp}(Z_k,N_k)$ is the experimental value
of each binding energy,  and $\sigma_k$ is the corresponding experimental
error.

In this case $\alpha$ is a $5 \times 5$ matrix because the semi-empirical mass
formula has 5 parameters, $c_{\rm vol}$, $c_{\rm surf}$, $c_{\rm asym}$,
$c_{\rm Coul}$, and $c_{\rm pair}$.

Furthermore, the inverse of the $\alpha$ matrix corresponds to the covariance
matrix $C = \alpha^{-1}$. In certain cases the covariance matrix can be used
to propagate the experimental uncertainty to any quantity calculated with the
model parameters $\vec{x}$. If $g$ is a function that depends on the
parameters $x_i$, the propagated uncertainty is given by

$$
	(\Delta g)^2 = \sum_{ij} {\left(\frac{\partial g}{\partial x_i} \right) \left(\frac{\partial g}{\partial x_j} \right) C_{ij} }
$$

Your code should do the following:

1. Ask for the name of the input file with the experimental data and read the experimental data
2. Construct the $\alpha_{ij}$ matrix and $\beta_i$ vector
3. Use the already provided subroutines for LU decomposition to invert the $\alpha$ matrix
4. Use the inverse matrix to solve the system $\alpha \cdot \vec{x} = \vec{\beta}$
5. Print to screen the best fit parameters with its corresponding uncertainties.
5. Write a file containing the experimental values, experimental uncertainties, theoretical values and theoretical uncertainties.

### Advanced Project: Neutron dripline and Shell structure.

#### Part I (worth 20%)

Now that you have a theoretical model to calculate the binding energy of any
isotope determined by $Z$ and $N$ you can use that model to make predictions. 

Write a subroutine that for every value of $Z$ between 1 and 118 finds the
most stable isotope. That is, the value of $N$ for which the binding energy
**per nucleon** is the lowest (i.e. the largest negative). This is sometimes
referred as *the valley of stability*

The neutron drip-line is defined as the maximum values of $N$ which correspond
to bound nuclei, for a given $Z$, that is for which the 1 neutron separation
energy $S_n = BE(Z,N-1) - BE(Z,N) > 0$.

Write another subroutine that for every value of $Z$ between 1 and 118 finds
the position of the neutron drip-line. That is, the largest value of $N$ for
which the separation energy $S_n$ is positive. 

Finally, write a file with the positions of  valley of stability and the
neutron drip-line. Then, use the jupyter notebook to plot the valley of
stability and the neutron dripline

#### Part II (worth 20%)

If you compare the experimental binding  energies (the input from the data
file) with your calculated binding energies, you will find that there are
significant deviations, much larger than either the experimental errors or
your calculated theoretical uncertainties. This is because of systematic
variations not included in the semi-empirical formula, namely the existence of
shells.

Use the jupyter notebook to plot the deviation of the theoretical binding
energy (include the theoretical error bars) from the experimental binding
energy. Do not take the absolute value; the deviations will be both positive
and negative. Make two plots: the deviation as a function of Z, and another as
a function of N. You will mostly have multiple points for each value of Z and
N, and that's okay. You should see deviations peaking around the so-called
magic numbers. Be sure to include appropriate units on your axes.

Discuss in the notebook if there's any pattern in the difference between
theoretical and experimental values and how would you explain the existence
and origin of such pattern.

Make two more plots. One for the experimental uncertainty as a function of $Z$
and one of your calculated theoretical uncertainties as a function of $Z$.
You'll probably see that your theoretical uncertainties are **much** smaller
of the experimental ones. Discuss why in the notebook 

### Super fun extra credit: Improve the semi-empirical mass formula (worth 10%)

Modify your FORTRAN code and invent your own term for the semi-empirical
formula, some function of $Z$ and $N$, say $1/\log(Z)$ (Do not copy anyone
else's term). Use the jupyter notebook to compute the reduced $\chi^2$ for
your data set, that is,

$$
	\chi^2_{\rm red} = \frac{1}{M-K} \sum_{i=1}^M {\frac{(BE_{\rm exp}(Z_i,N_i) - BE_{\rm fit}(Z_i,N_i))^2}{\sigma_i^2}}
$$

where $K$ is the number of parameters, $M$ the number of experimental data and
$M-K$ is known as the *degrees of freedom*. Note that the original model had
$K=5$, but your knew model will have $K=6$. The person who submits an improved
binding energy formula with the best verifiable (by me) improvement in reduced
$\chi^2$ will get an additional 10% credit!

## General Notes


For full credit on all parts, your program should be well-commented, and input
and output clear and easy to use.