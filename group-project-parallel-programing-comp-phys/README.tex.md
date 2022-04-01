# Group Project: Solving the two dimensional Poisson equation

## Important Considerations

### Set up and submission

For this group project you will form teams. Each team will have access to a
single repository (instead of each student having their own). Before you start
working you should decide which work-flow you'll keep. You can all decide to
work on the same master branch (and coordinate commits and push events) or you
can make individual branches and coordinate the merging into a master branch
through pull requests (which I will NOT coordinate). Your final version of the
code should be on the `master` branch at the time of submission. 

If you have significant problems with your code you can raise an issue so that
I cant take a look (remember to put me as an assignee). However if your code
is clearly 'buggy' and it does not compile due to syntax errors I will not
provide feedback.

If you're getting compilation errors that you don't really understand we can
take a look together during office hours or class.

Don't forget to push your final commit before the submission deadline so that
I can take a look at your code.

### Division of work

The main tasks for this project are:

* Writing serial version
* Validation of the serial version.
* Parallelization of the code using OpenMP
* Validation of the parallel code.
* Timing and scaling tests.
* Production runs
* Producing final plots.
* Creating the written project results.
* Creating and giving an oral presentation on the day scheduled for the final exam. (Monday December 16th from 1:00 to 3:00 pm)

Your write-up should be part of your `README.md` file in the `src` directory.
Be sure to use markdown syntax in order to improve the readability of your
document. You can ***and should*** include figures (and or tables) to better
present your results (including numerical results, convergence, scaling and
parallel speedup). Look at the markdown cheat sheet for the appropriate
syntax. While there's no minimum length for the written report it should be as
detailed as possible. A report that gives the bare minimum information will
get you the bare minimum grade 

Oral presentations should be approximately 15 minutes.

Your groups can choose how to divide up the work. I expect each group member
to participate, although people can take on different tasks. For example, one
person could code, another to run, and a third to write up. Alternately, you
each could parallelize your own code and compare to see which is fastest. The
role each person plays must be clearly (and believably) stated in the written
report. I will also have access to your GitHub activity which I may use to
asses how evenly the work was distributed among group members.

Furthermore each group should jointly discuss (among them as well as the report
and presentation):

* The integration algorithm (I suggest Boole's, but you may make another choice)
* How to parallelize, i.e., what loops to choose
* How to test and validate the code
* Convergence criteria: how to know when you have a reasonable `n_max`.

You can also include pieces of code in your `README.md` (again, look at your
cheat sheet for syntax)

Grade depends upon the success of the code, demonstration and measurement of
speed-up with OpenMP parallelization, level of documentation, and the clarity
and quality of the oral presentation and of the written report. 

## Assignment

In this project you will solve Poisson's equation, $\nabla^2 \phi (\vec{r}) =
- 4 \pi \rho(\vec{r})$ ,where $\phi$ is the electrostatic potential and $\rho$
is the source charge density. Towards the end of the course we will learn how
to solve this via a "relaxation" method, but here we will transform the
differential equation into a matrix problem in a given basis. The main
numerical work will be Fourier integrals.

We will work in two dimensions, so that the full equation becomes
$$
\left(\frac{\partial^2}{\partial x^2} + \frac{\partial^2}{\partial y^2} \right) \phi(x,y) = - 4 \pi \rho(x,y)
$$

We will place this in a metal rectangular box with sides of length $L_x$ and
$L_y$. This means the gradient of the potential at the surfaces must be zero,
that is, if we place the walls at $x=0$ and $L_x$, and at $y=0$ and $L_y$, then
$$
\begin{align}
	\left. \frac{\partial \phi}{\partial x} \right|_{x = 0} = \left. \frac{\partial \phi}{\partial x} \right|_{x = L_x} = & 0 \\
	\left. \frac{\partial \phi}{\partial y} \right|_{y = 0} = \left. \frac{\partial \phi}{\partial y} \right|_{y = L_y} = & 0 
\end{align}
$$

This is easily accomplished by expanding the potential in basis functions
which automatically satisfy these conditions, that is cosines:
$$
\phi(x,y) = \sum_{m,n}^{N_{\rm max}} c_{m,n} \frac{2}{\sqrt{L_x L_y}} \cos \left(\frac{m \pi x}{L_x} \right) \cos \left(\frac{n \pi y}{L_y} \right)
$$
These basis functions have been chosen so as to be already normalized.

In this basis, the problem becomes almost trivial:
$$
\left[ \left( \frac{m \pi}{L_x} \right)^2 + \left( \frac{n \pi}{L_y} \right)^2 \right] c_{m,n} = 4 \pi \rho_{m,n}
$$

to be solved for $c_{m,n}$ and where the source term is now

$$
\rho_{m,n} = \frac{2}{\sqrt{L_x L_y}} \int_0^{L_x} \int_0^{L_y} \rho(x,y) \cos \left( \frac{m \pi x}{L_x}\right) \cos \left( \frac{n \pi y}{L_y}\right) dx dy
$$

This two dimensional integral is the main computational work. For this you can
***and should*** use your `quadrature` module from assignment two. The number
of sample points for the quadrature ***does not*** need to be the same as the
number of samples for the Fourier coefficients. You may hard code the number
of quadrature sample points. If your quadrature subroutines are general enough
you just need to copy the `quadrature.f90` file into this repository and you
wont even need to make changes to the source code. However you will need to
modify the `makefile` in this repository to include the correct dependencies.

For the source term, we will use the function
$$
\rho(x,y) = \frac{\rho_0}{\pi R_x R_y} \exp \left[- \frac{(x-x_0)^2}{R_x^2} - \frac{(y-y_0)^2}{R_y^2} \right]
$$

Your code should receive, via a `namelist` file given as an argument, the
following:

* The dimensions of the box, $L_x$ and $L_y$ (which may be different)
* The total charge $\rho_0$.
* The center of the charge distribution $x_0$ and $y_0$
* The widths $R_x$ and $R_y$
* The max index $N_{\rm max}$, which is the maximum value for both indices $m$ and $n$.

You may add additional `namelists` to the input file (e.g. name of the output
file, number of sample points for the quadrature, step size in each direction
when writing results for plots), just be sure to give default values to all
variables in all `namelists`.

Create a jupyter notebook to show your resulting potential $\phi$ in a two
dimensional plot. Either through iso-potential curves (`plt.contour()`) or by a
color plot (`plt.imshow()`). I'll leave up to you to decide how to better
present your results and to look at the necessary documentation.

### Parallelization

You should identify which `do` loop (or loops) to parallelize with openMP.
Although nested parallelism is possible (parallelizing a loop that is inside of
another loop that is already parallelized) I recommend that you stick to
single loop parallelization. That doesn't mean that you can not parallelize
two different loops that are not nested. If a `do` loop is coded inside of a
subroutine (or function) that gets called from another `do` loop in a
different subroutine ***those two loops are nested***.

## General Notes

As usual, for full credit on all parts, your program should be well-commented,
and input and output clear and easy to use with an informative `README.md` in
your `src/` directory.