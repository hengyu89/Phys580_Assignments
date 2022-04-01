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

Consider a reactor of depth <img src="/tex/78ec2b7008296ce0561cf83393cb746d.svg?invert_in_darkmode&sanitize=true" align=middle width=14.06623184999999pt height=22.465723500000017pt/> (along the <img src="/tex/332cc365a4987aacce0ead01b8bdcc0b.svg?invert_in_darkmode&sanitize=true" align=middle width=9.39498779999999pt height=14.15524440000002pt/> axis), width <img src="/tex/84c95f91a742c9ceb460a83f9b5090bf.svg?invert_in_darkmode&sanitize=true" align=middle width=17.80826024999999pt height=22.465723500000017pt/> (along the <img src="/tex/deceeaf6940a8c7a5a02373728002b0f.svg?invert_in_darkmode&sanitize=true" align=middle width=8.649225749999989pt height=14.15524440000002pt/>
axis), and height <img src="/tex/7b9a0316a2fcd7f01cfd556eedf72e96.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/> (along the <img src="/tex/f93ce33e511096ed626b4719d50f17d2.svg?invert_in_darkmode&sanitize=true" align=middle width=8.367621899999993pt height=14.15524440000002pt/> axis). Assume the reactor emits neutrons
uniformly throughout its volume and that the emission rate is 1 neutron per
second per cubic meter.

Now place a neutron detector a distance <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/> in front of the reactor, and
over a distance <img src="/tex/14adeddbb1889c9aba973ba30e7bce77.svg?invert_in_darkmode&sanitize=true" align=middle width=14.61197759999999pt height=14.15524440000002pt/> along the front from one corner (either corner, it does
not matter), as seen in the image bellow.

![Reactor Diagram](/reactor.png)

### Basic Project, Part I. Newton-Coates quadrature (worth 50%)

The goal of this part of the project is to plot the total flux as a function
of the distance <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/>. Start the program by asking the user to input the
values for <img src="/tex/78ec2b7008296ce0561cf83393cb746d.svg?invert_in_darkmode&sanitize=true" align=middle width=14.06623184999999pt height=22.465723500000017pt/> <img src="/tex/84c95f91a742c9ceb460a83f9b5090bf.svg?invert_in_darkmode&sanitize=true" align=middle width=17.80826024999999pt height=22.465723500000017pt/>, <img src="/tex/7b9a0316a2fcd7f01cfd556eedf72e96.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/>, <img src="/tex/14adeddbb1889c9aba973ba30e7bce77.svg?invert_in_darkmode&sanitize=true" align=middle width=14.61197759999999pt height=14.15524440000002pt/>, <img src="/tex/65df5092b628135b17f9e2ff496508f3.svg?invert_in_darkmode&sanitize=true" align=middle width=31.17592499999999pt height=14.15524440000002pt/>, <img src="/tex/9b5e1ed767f2e8c91ff2a79a3a76f15d.svg?invert_in_darkmode&sanitize=true" align=middle width=33.65311454999999pt height=14.15524440000002pt/>, <img src="/tex/aa7089e7aa1a6740da0a1fb2ca584ef0.svg?invert_in_darkmode&sanitize=true" align=middle width=32.84489504999999pt height=14.15524440000002pt/>
and the number of lattice points <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/>. Using these inputs and Boole's rule the
code should calculate the integrated flux measured at the detector, at <img src="/tex/00cc9160d1ffd090f522f4238cf3c655.svg?invert_in_darkmode&sanitize=true" align=middle width=52.29465614999999pt height=24.65753399999998pt/>. Remember that the flux from a small volume <img src="/tex/89ad9376f3db880dad157c1eb37edb4c.svg?invert_in_darkmode&sanitize=true" align=middle width=95.79533204999998pt height=22.831056599999986pt/> at a distance
<img src="/tex/89f2e0d2d24bcf44db73aab8fc03252c.svg?invert_in_darkmode&sanitize=true" align=middle width=7.87295519999999pt height=14.15524440000002pt/> is <img src="/tex/d126d7f8181b06a1f0711e7e6eba587b.svg?invert_in_darkmode&sanitize=true" align=middle width=101.65478069999999pt height=30.648287999999997pt/> where <img src="/tex/04b366e9e3087ea59f7ce8245dd66995.svg?invert_in_darkmode&sanitize=true" align=middle width=108.49707329999997pt height=24.65753399999998pt/> is the
distance from each small volume (located at <img src="/tex/332cc365a4987aacce0ead01b8bdcc0b.svg?invert_in_darkmode&sanitize=true" align=middle width=9.39498779999999pt height=14.15524440000002pt/>, <img src="/tex/deceeaf6940a8c7a5a02373728002b0f.svg?invert_in_darkmode&sanitize=true" align=middle width=8.649225749999989pt height=14.15524440000002pt/>, <img src="/tex/f93ce33e511096ed626b4719d50f17d2.svg?invert_in_darkmode&sanitize=true" align=middle width=8.367621899999993pt height=14.15524440000002pt/>) to the detector
(located at <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/>, <img src="/tex/14adeddbb1889c9aba973ba30e7bce77.svg?invert_in_darkmode&sanitize=true" align=middle width=14.61197759999999pt height=14.15524440000002pt/>)

*Hint*: While the origin can be placed anywhere, it is convenient to place in
at one of the front corners. Then the integral you need to evaluate is
<p align="center"><img src="/tex/58864431b363686667e28477043097d4.svg?invert_in_darkmode&sanitize=true" align=middle width=373.1377386pt height=41.5592232pt/></p>

**The <img src="/tex/df33724455416439909c33a7db76b2bc.svg?invert_in_darkmode&sanitize=true" align=middle width=12.785434199999989pt height=19.1781018pt/> and <img src="/tex/2a69f75630cce402c7c381036296bca9.svg?invert_in_darkmode&sanitize=true" align=middle width=12.785434199999989pt height=19.1781018pt/> signs above are *very* important**. Be sure that you
understand how the integral of the flux from a small volume <img src="/tex/7ccb42e2821b2a382a72de820aaec42f.svg?invert_in_darkmode&sanitize=true" align=middle width=21.79800149999999pt height=22.831056599999986pt/> results in
the expression above.

When writing a long program, it is always good practice to break up the
problem into several intermediate projects that can be tested independently
from each other. The main tasks that you can focus are as follows

1.  Construct a one-dimensional quadrature routine using Boole’s rule. Write
it based upon the Simpson’s rule routine we discussed in class. Remember to
appropriately document your subroutine. Be sure to put in an error trap to
test that <img src="/tex/2165d5f835a1cb2082f2a3aa8228a032.svg?invert_in_darkmode&sanitize=true" align=middle width=43.31036984999999pt height=22.465723500000017pt/> (<img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/> is the number of lattice points) is a multiple of 4.
Test your subroutine against the Simpson’s routine for some finite integral
whose exact answer you know; Boole’s should have a smaller error.

2.  Write a subroutine that reads in the information you need (e.g., <img src="/tex/78ec2b7008296ce0561cf83393cb746d.svg?invert_in_darkmode&sanitize=true" align=middle width=14.06623184999999pt height=22.465723500000017pt/>, <img src="/tex/84c95f91a742c9ceb460a83f9b5090bf.svg?invert_in_darkmode&sanitize=true" align=middle width=17.80826024999999pt height=22.465723500000017pt/>,
<img src="/tex/7b9a0316a2fcd7f01cfd556eedf72e96.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/>, <img src="/tex/14adeddbb1889c9aba973ba30e7bce77.svg?invert_in_darkmode&sanitize=true" align=middle width=14.61197759999999pt height=14.15524440000002pt/>, etc) Be sure to make it clear what each variable is. You will also
need to ask for the number of lattice points in each direction. It is allowed
(not required) to use the same number of lattice points in each direction,
even when <img src="/tex/78ec2b7008296ce0561cf83393cb746d.svg?invert_in_darkmode&sanitize=true" align=middle width=14.06623184999999pt height=22.465723500000017pt/>, <img src="/tex/84c95f91a742c9ceb460a83f9b5090bf.svg?invert_in_darkmode&sanitize=true" align=middle width=17.80826024999999pt height=22.465723500000017pt/>, and <img src="/tex/7b9a0316a2fcd7f01cfd556eedf72e96.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/> are not equal.

3. Write a subroutine that will do the 3-dimensional integral. To do the 3-D
integral itself, write it as nested one-dimensional integrals, that is, the
integral is really
<p align="center"><img src="/tex/a15ed7a739ab7dde9764feff52bb18b9.svg?invert_in_darkmode&sanitize=true" align=middle width=85.6170546pt height=41.15109735pt/></p>
where
<p align="center"><img src="/tex/0859a7dc4b57bd0c32e436def418c20f.svg?invert_in_darkmode&sanitize=true" align=middle width=156.3851421pt height=41.15109735pt/></p>
and
<p align="center"><img src="/tex/177b99454e5d141de7754d7621e8fd53.svg?invert_in_darkmode&sanitize=true" align=middle width=335.751339pt height=41.5592232pt/></p>

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
can easily calculate. For large <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/>, you can approximate the reactor as a
point source; in this case the most sensible approach is to place all the
source at the center. The flux then is just <img src="/tex/feee0f88db25dfcdf46fe04a46c6e7e6.svg?invert_in_darkmode&sanitize=true" align=middle width=214.2855297pt height=28.670654099999997pt/>. Code this result in your project,
and confirm that as <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/> gets large (much larger than any of D, W, or H) that
your exact result comes close to this estimate.

You must also check that your answers are not very sensitive to the number of
points you take. Try different number of points and see that the answers are
very similar. (How similar? You should think on this...)


5. Using the provided jupyter notebook and the results from your FORTRAN code
illustrate the <img src="/tex/c0cf52c248630ee62f65502b3186e253.svg?invert_in_darkmode&sanitize=true" align=middle width=30.86392154999999pt height=26.76175259999998pt/> law and deviations from it. With fixed <img src="/tex/78ec2b7008296ce0561cf83393cb746d.svg?invert_in_darkmode&sanitize=true" align=middle width=14.06623184999999pt height=22.465723500000017pt/>, <img src="/tex/84c95f91a742c9ceb460a83f9b5090bf.svg?invert_in_darkmode&sanitize=true" align=middle width=17.80826024999999pt height=22.465723500000017pt/>, <img src="/tex/7b9a0316a2fcd7f01cfd556eedf72e96.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/>
(not equal to each other), fixed <img src="/tex/14adeddbb1889c9aba973ba30e7bce77.svg?invert_in_darkmode&sanitize=true" align=middle width=14.61197759999999pt height=14.15524440000002pt/> (nonzero), and <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/> varying from
<img src="/tex/65df5092b628135b17f9e2ff496508f3.svg?invert_in_darkmode&sanitize=true" align=middle width=31.17592499999999pt height=14.15524440000002pt/> to <img src="/tex/9b5e1ed767f2e8c91ff2a79a3a76f15d.svg?invert_in_darkmode&sanitize=true" align=middle width=33.65311454999999pt height=14.15524440000002pt/>, plot both your result from Boole's quadrature
and the approximate answer <img src="/tex/547cf353fdd4fe449b54f98dfd7d70b4.svg?invert_in_darkmode&sanitize=true" align=middle width=214.2855297pt height=28.670654099999997pt/>. For large enough <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/> the two curves should
approach each other; for small enough <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/> they should diverge. Choose
minimum and maximum values of <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/> so that your graph clearly illustrates
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

#### Important

Remember to add a `README.md` file inside the `/src` directory. This file should include a brief 
explanation of the program, expected input and output, and instructions for compilation. **Missing this file 
will have an inpact on your grade**

### Advanced Project (worth 25%).

Using both Newton-Coates and MC quadrature, assume a modified reactor
configuration: the basic reaction dimensions are the same, defined by <img src="/tex/78ec2b7008296ce0561cf83393cb746d.svg?invert_in_darkmode&sanitize=true" align=middle width=14.06623184999999pt height=22.465723500000017pt/>,
<img src="/tex/84c95f91a742c9ceb460a83f9b5090bf.svg?invert_in_darkmode&sanitize=true" align=middle width=17.80826024999999pt height=22.465723500000017pt/>, <img src="/tex/7b9a0316a2fcd7f01cfd556eedf72e96.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/>, but a sphere of radius <img src="/tex/89f2e0d2d24bcf44db73aab8fc03252c.svg?invert_in_darkmode&sanitize=true" align=middle width=7.87295519999999pt height=14.15524440000002pt/> (to be input by the user) centered on the
center of the reactor is excluded, that is, it is a rectangular block with a
spherical hollow inside.

With Boole's quadrature a good approach is to write a routine that calculates
the flux of a solid sphere and subtract that from a calculation of the flux of 
a solid box (which you already implemented in the basic project).

In spherical coordinates the flux from a small volume <img src="/tex/07af76465f95548c1eae6d1130f60a38.svg?invert_in_darkmode&sanitize=true" align=middle width=158.1432204pt height=26.76175259999998pt/> at a distance <img src="/tex/89f2e0d2d24bcf44db73aab8fc03252c.svg?invert_in_darkmode&sanitize=true" align=middle width=7.87295519999999pt height=14.15524440000002pt/> is <img src="/tex/15681d0b79a83ed8466f1980881db87e.svg?invert_in_darkmode&sanitize=true" align=middle width=97.77387345pt height=36.460254599999985pt/> where <img src="/tex/170b2bc042ad7e1225419be0f79c8929.svg?invert_in_darkmode&sanitize=true" align=middle width=86.32041659999999pt height=24.7161288pt/> is the
distance from the small volume (with coordinates <img src="/tex/37bb59bcb3c8c723506af9f3796c92c5.svg?invert_in_darkmode&sanitize=true" align=middle width=11.66291774999999pt height=24.7161288pt/>, <img src="/tex/27e556cf3caa0673ac49a8f0de3c73ca.svg?invert_in_darkmode&sanitize=true" align=middle width=8.17352744999999pt height=22.831056599999986pt/>, <img src="/tex/f50853d41be7d55874e952eb0d80c53e.svg?invert_in_darkmode&sanitize=true" align=middle width=9.794543549999991pt height=22.831056599999986pt/>) to
the detector located at a distance <img src="/tex/1e438235ef9ec72fc51ac5025516017c.svg?invert_in_darkmode&sanitize=true" align=middle width=12.60847334999999pt height=22.465723500000017pt/> from the center of the sphere. See the
diagram below for a clear picture. 

Due to the spherical symmetry of the problem, the <img src="/tex/f50853d41be7d55874e952eb0d80c53e.svg?invert_in_darkmode&sanitize=true" align=middle width=9.794543549999991pt height=22.831056599999986pt/> variable can be
integrated out resulting in a factor of <img src="/tex/70f9064f0ff73b7e521f0c1563932b2f.svg?invert_in_darkmode&sanitize=true" align=middle width=18.179315549999988pt height=21.18721440000001pt/> and the total flux is given by:

<p align="center"><img src="/tex/f098a562766bc036ad0e6875537181c5.svg?invert_in_darkmode&sanitize=true" align=middle width=289.9712013pt height=38.65053225pt/></p>

![Reactor Diagram](/sphere.png)

Make sure you understand why <img src="/tex/db01b8031e06e3a5e11d1c620f3773d3.svg?invert_in_darkmode&sanitize=true" align=middle width=186.02524544999997pt height=26.76175259999998pt/>

The Monte Carlo approach is much more simple. All you need to do is define  a
new function that is equal to <img src="/tex/29632a9bf827ce0200454dd32fc3be82.svg?invert_in_darkmode&sanitize=true" align=middle width=8.219209349999991pt height=21.18721440000001pt/> if the random point sampled is inside the
sphere, and equal to the original function <img src="/tex/42ba81f9452877dc74ea094b920bb4b2.svg?invert_in_darkmode&sanitize=true" align=middle width=150.6771915pt height=27.77565449999998pt/> if the sampled point is outside of the sphere. You
don't even need to change your integration variables to spherical coordinates

As a check on your calculations, as you make <img src="/tex/89f2e0d2d24bcf44db73aab8fc03252c.svg?invert_in_darkmode&sanitize=true" align=middle width=7.87295519999999pt height=14.15524440000002pt/> smaller and smaller you
should regain the results from the basic project. You can make a graph with
every parameter fixed (including <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/> and <img src="/tex/14adeddbb1889c9aba973ba30e7bce77.svg?invert_in_darkmode&sanitize=true" align=middle width=14.61197759999999pt height=14.15524440000002pt/>) and change <img src="/tex/89f2e0d2d24bcf44db73aab8fc03252c.svg?invert_in_darkmode&sanitize=true" align=middle width=7.87295519999999pt height=14.15524440000002pt/> within a
certain range between <img src="/tex/204818c9146e4a1fcc59b808a1b768a1.svg?invert_in_darkmode&sanitize=true" align=middle width=29.19725654999999pt height=14.15524440000002pt/> and <img src="/tex/566c390f574e246bae06fd9836be9c52.svg?invert_in_darkmode&sanitize=true" align=middle width=31.67444609999999pt height=14.15524440000002pt/>. Submit at the same time
as your basic project.

## General Notes

For full credit on all parts, your program should be well-commented, and input
and output clear and easy to use.

Some useful formulas:

Boole's rule:
<p align="center"><img src="/tex/c31478c8780f68ba3f1ca3e66bf2c573.svg?invert_in_darkmode&sanitize=true" align=middle width=580.4055708pt height=39.88624365pt/></p>

Basic Monte Carlo sampling with <img src="/tex/fb97d38bcc19230b0acd442e17db879c.svg?invert_in_darkmode&sanitize=true" align=middle width=17.73973739999999pt height=22.465723500000017pt/> points over a 3-dimensional volume <img src="/tex/a9a3a4a202d80326bda413b5562d5cd1.svg?invert_in_darkmode&sanitize=true" align=middle width=13.242037049999992pt height=22.465723500000017pt/>
<p align="center"><img src="/tex/8ec30b1c1e6010b3e22c3a9af9c90818.svg?invert_in_darkmode&sanitize=true" align=middle width=242.96238945pt height=47.806078649999996pt/></p>

The error estimate for this integral is <img src="/tex/820220dfbe9802c66d487715a9325e0f.svg?invert_in_darkmode&sanitize=true" align=middle width=87.62527949999999pt height=28.670654099999997pt/>, where
<p align="center"><img src="/tex/393a6f5893c035a795fb62c51e3a78b8.svg?invert_in_darkmode&sanitize=true" align=middle width=276.6365151pt height=53.954721150000005pt/></p>

is the intrinsic variance in the function <img src="/tex/190083ef7a1625fbc75f243cffb9c96d.svg?invert_in_darkmode&sanitize=true" align=middle width=9.81741584999999pt height=22.831056599999986pt/>.

Note:  the number of lattice points, <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/>, taken for Boole's rule calculations,
and the number of Monte Carlo sample, <img src="/tex/fb97d38bcc19230b0acd442e17db879c.svg?invert_in_darkmode&sanitize=true" align=middle width=17.73973739999999pt height=22.465723500000017pt/>, are not the same; they are
completely independent numbers.
