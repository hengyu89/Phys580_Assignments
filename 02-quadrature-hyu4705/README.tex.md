# Neutron flux from a reactor. Quadrature Techniques

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

In order to help you with this assignment a starter code is included in this 
repository. Although the starter code compiles using the command `make` it
does not produce the expected output. You need to modify the current code in
order to perform the tasks outlined below.

Consider a reactor of depth $D$ (along the $x$ axis), width $W$ (along the $y$
axis), and height $H$ (along the $z$ axis). Assume the reactor emits neutrons
uniformly throughout its volume and that the emission rate is 1 neutron per
second per cubic meter.

Now place a neutron detector a distance $x_0$ in front of the reactor, and
over a distance $y_0$ along the front from one corner (either corner, it does
not matter), as seen in the image bellow.

![Reactor Diagram](/reactor.png)

### Basic Project, Part I. Newton-Coates quadrature (worth 50%)

The goal of this part of the project is to plot the total flux as a function
of the distance $x_0$. Start the program by asking the user to input the
values for $D$ $W$, $H$, $y_0$, $x_{\rm min}$, $x_{\rm max}$, $x_{\rm step}$
and the number of lattice points $N$. Using these inputs and Boole's rule the
code should calculate the integrated flux measured at the detector, at $(x_0,
y_0)$. Remember that the flux from a small volume $dV=dxdydz$ at a distance
$r$ is $\frac{dxdydz}{4 \pi r^2(x,y,z,x_0,y_0)}$ where $r(x,y,z,x_0,y_0)$ is the
distance from each small volume (located at $x$, $y$, $z$) to the detector
(located at $x_0$, $y_0$)

*Hint*: While the origin can be placed anywhere, it is convenient to place in
at one of the front corners. Then the integral you need to evaluate is
$$
\int_0^D dx \int_0^W dy \int_0^H dz \frac{1}{4 \pi \left[ (x+x_0)^2 + (y-y_0)^2 + z^2 \right]}
$$

**The $+$ and $-$ signs above are *very* important**. Be sure that you
understand how the integral of the flux from a small volume $dV$ results in
the expression above.

When writing a long program, it is always good practice to break up the
problem into several intermediate projects that can be tested independently
from each other. The main tasks that you can focus are as follows

1.  Construct a one-dimensional quadrature routine using Boole’s rule. Write
it based upon the Simpson’s rule routine we discussed in class. Remember to
appropriately document your subroutine. Be sure to put in an error trap to
test that $N - 1$ ($N$ is the number of lattice points) is a multiple of 4.
Test your subroutine against the Simpson’s routine for some finite integral
whose exact answer you know; Boole’s should have a smaller error.

2.  Write a subroutine that reads in the information you need (e.g., $D$, $W$,
$H$, $y_0$, etc) Be sure to make it clear what each variable is. You will also
need to ask for the number of lattice points in each direction. It is allowed
(not required) to use the same number of lattice points in each direction,
even when $D$, $W$, and $H$ are not equal.

3. Write a subroutine that will do the 3-dimensional integral. To do the 3-D
integral itself, write it as nested one-dimensional integrals, that is, the
integral is really
$$
\int_0^D dx f(x),
$$
where
$$
f(x) = \int_0^W dy g(x,y),
$$
and
$$
g(x,y) = \int_0^H dz \frac{1}{4 \pi \left[ (x + x_0)^2 + (y - y_0)^2 + z^2 \right]}
$$

In other words, your outermost loop is over x; then over y; then over z. The
pseudo code for this nested loops looks like this:

```
loop over x
	loop over y
		loop over z
			compute 1/(4 pi r**2) for x,y,z
			fill array for the z-integral
		end loop over z
		pass array to Boole's rule subroutine to integrate over z; this gives you g(x,y)
		fill array for the y-integral
	end loop over y
	pass array to Boole's rule subroutine to integrate over y; this gives you f(x)
	fill array for the x-integral
end loop over x
pass array to Boole's rule subroutine to integrate over x; this gives you the integrated flux
```


4.  Testing. In order to test, one must think of a result you know already or
can easily calculate. For large $x_0$, you can approximate the reactor as a
point source; in this case the most sensible approach is to place all the
source at the center. The flux then is just $\frac{DWH}{4 \pi \left[ (x_0 +
D/2)^2 + (y_0 - W/2)^2 + (H/2)^2 \right]}$. Code this result in your project,
and confirm that as $x_0$ gets large (much larger than any of D, W, or H) that
your exact result comes close to this estimate.

You must also check that your answers are not very sensitive to the number of
points you take. Try different number of points and see that the answers are
very similar. (How similar? You should think on this...)


5. Using the provided jupyter notebook and the results from your FORTRAN code
illustrate the $1/r^2$ law and deviations from it. With fixed $D$, $W$, $H$
(not equal to each other), fixed $y_0$ (nonzero), and $x_0$ varying from
$x_{\rm min}$ to $x_{\rm max}$, plot both your result from Boole's quadrature
and the approximate answer $\frac{DWH}{4 \pi \left[ (x_0 + D/2)^2 + (y_0 -
W/2)^2 + (H/2)^2 \right]}$. For large enough $x_0$ the two curves should
approach each other; for small enough $x_0$ they should diverge. Choose
minimum and maximum values of $x_0$ so that your graph clearly illustrates
these two limits.

### Basic Project, Part II. Monte Carlo quadrature (worth 25%)

Use Monte Carlo integration to achieve the same ends. In this case, you do not
break down the integral into 3 one-dimensional integrals, but simply sample
points throughout the volume of the reactor. **For full credit, you must
compute the statistical uncertainty in the integral**. For the Monte Carlo,
you do not need to do any rejection techniques, simply generate uniformly
distributed random points within the volume of the reactor.

Add to your second graph your Monte Carlo results. Does your MC integral and
your Newton-Coates integrals agree within the error bars? 

### Advanced Project (worth 25%).

Using both Newton-Coates and MC quadrature, assume a modified reactor
configuration: the basic reaction dimensions are the same, defined by $D$,
$W$, $H$, but a sphere of radius $r$ (to be input by the user) centered on the
center of the reactor is excluded, that is, it is a rectangular block with a
spherical hollow inside.

With Boole's quadrature a good approach is to write a routine that calculates
the flux of a solid sphere and subtract that from a calculation of the flux of 
a solid box (which you already implemented in the basic project).

In spherical coordinates the flux from a small volume $dV=r'^2 \sin (\theta)
dr d\theta d\phi$ at a distance $r$ is $\frac{r'^2 \sin (\theta) dr' d\theta
d\phi}{4 \pi d^2(r',\theta,\phi,R)}$ where $d(r',\theta,\phi,R)$ is the
distance from the small volume (with coordinates $r'$, $\theta$, $\phi$) to
the detector located at a distance $R$ from the center of the sphere. See the
diagram below for a clear picture. 

Due to the spherical symmetry of the problem, the $\phi$ variable can be
integrated out resulting in a factor of $2 \pi$ and the total flux is given by:

$$
	\int_0^r r'^2 dr' \int_0^\pi \frac{\sin \theta }{2 \left( r'^2 + R^2 - 2 r' R \cos \theta \right)} d \theta
$$

![Reactor Diagram](/sphere.png)

Make sure you understand why $d^2 = r'^2 + R^2 - 2 r' R \cos \theta$

The Monte Carlo approach is much more simple. All you need to do is define  a
new function that is equal to $0$ if the random point sampled is inside the
sphere, and equal to the original function $\frac{1}{4 \pi \left[ (x + x_0)^2 +
(y - y_0)^2 + z^2 \right]}$ if the sampled point is outside of the sphere. You
don't even need to change your integration variables to spherical coordinates

As a check on your calculations, as you make $r$ smaller and smaller you
should regain the results from the basic project. You can make a graph with
every parameter fixed (including $x_0$ and $y_0$) and change $r$ within a
certain range between $r_{\rm min}$ and $r_{\rm max}$. Submit at the same time
as your basic project.

## General Notes

For full credit on all parts, your program should be well-commented, and input
and output clear and easy to use.

Some useful formulas:

Boole's rule:
$$
	\int_{x_0}^{x_4} f(x) dx = \Delta x \frac{2}{45} \left[7 f(x_4) + 32 f(x_3) + 12 f(x_2) + 32 f(x_1) + 7 f(x_0) \right] + O(\Delta x^7)
$$

Basic Monte Carlo sampling with $M$ points over a 3-dimensional volume $V$
$$
	A = \int_V d^3 x f(\vec{x}) \approx V \frac{1}{M} \sum_{i=1}^M f( \vec{x_i} ),
$$

The error estimate for this integral is $\sigma_A = \frac{V}{\sqrt{M}} \sigma_f$, where
$$
	\sigma_f^2 = \frac{1}{M} \sum_{i=1}^M f^2( \vec{x_i} ) - \left( \frac{1}{M} \sum_{i=1}^M f( \vec{x_i} ) \right)^2
$$

is the intrinsic variance in the function $f$.

Note:  the number of lattice points, $N$, taken for Boole's rule calculations,
and the number of Monte Carlo sample, $M$, are not the same; they are
completely independent numbers.
