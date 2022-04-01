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
* Creating and giving an oral presentation on the day scheduled for the final exam. (Friday December 11th from 1:00 to 3:00 pm)

Your write-up should be part of your `README.md` file in the `src` directory.
Be sure to use markdown syntax in order to improve the readability of your
document. You can ***and should*** include figures (and or tables) to better
present your results (including numerical results, convergence, scaling and
parallel speedup). Look at the markdown cheat sheet for the appropriate
syntax. While there's no minimum length for the written report it should be as
detailed as possible. A good rule of thumb is that your written report should
have at least the same content as your presentation. A report that gives
the bare minimum information will get you the bare minimum grade. 

Oral presentations should be approximately 15 minutes.

Your group can choose how to divide up the work. I expect each group member
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

In this project you will solve Poisson's equation, <img src="/tex/a728fdceeb7edb6d08c57ab25335a6f7.svg?invert_in_darkmode&sanitize=true" align=middle width=133.56565365pt height=26.76175259999998pt/> ,where <img src="/tex/f50853d41be7d55874e952eb0d80c53e.svg?invert_in_darkmode&sanitize=true" align=middle width=9.794543549999991pt height=22.831056599999986pt/> is the electrostatic potential and <img src="/tex/6dec54c48a0438a5fcde6053bdb9d712.svg?invert_in_darkmode&sanitize=true" align=middle width=8.49888434999999pt height=14.15524440000002pt/>
is the source charge density. Towards the end of the course we will learn how
to solve this via a "relaxation" method, but here we will transform the
differential equation into a matrix problem in a given basis. The main
numerical work will be Fourier integrals.

We will work in two dimensions, so that the full equation becomes
<p align="center"><img src="/tex/31659c8b0dc6dfd77f3ad90c50fb13cf.svg?invert_in_darkmode&sanitize=true" align=middle width=254.44296074999997pt height=40.11819404999999pt/></p>

We will place this in a metal rectangular box with sides of length <img src="/tex/9dbcef13f3e6981dfe63f653112a933f.svg?invert_in_darkmode&sanitize=true" align=middle width=18.64161584999999pt height=22.465723500000017pt/> and
<img src="/tex/ac6244c7cc0673f3a8d51603f75bcffe.svg?invert_in_darkmode&sanitize=true" align=middle width=18.26684969999999pt height=22.465723500000017pt/>. This means the gradient of the potential at the surfaces must be zero,
that is, if we place the walls at <img src="/tex/8436d02a042a1eec745015a5801fc1a0.svg?invert_in_darkmode&sanitize=true" align=middle width=39.53182859999999pt height=21.18721440000001pt/> and <img src="/tex/9dbcef13f3e6981dfe63f653112a933f.svg?invert_in_darkmode&sanitize=true" align=middle width=18.64161584999999pt height=22.465723500000017pt/>, and at <img src="/tex/a42b1c71ca6ab3bfc0e416ac9b587993.svg?invert_in_darkmode&sanitize=true" align=middle width=38.78604674999999pt height=21.18721440000001pt/> and <img src="/tex/ac6244c7cc0673f3a8d51603f75bcffe.svg?invert_in_darkmode&sanitize=true" align=middle width=18.26684969999999pt height=22.465723500000017pt/>, then
<p align="center"><img src="/tex/121b2aba0948920e666965710a533721.svg?invert_in_darkmode&sanitize=true" align=middle width=164.84245965pt height=92.0098938pt/></p>

This is easily accomplished by expanding the potential in basis functions
which automatically satisfy these conditions, that is cosines:
<p align="center"><img src="/tex/446111e69ab8e69beb7d8ffa09e7eff6.svg?invert_in_darkmode&sanitize=true" align=middle width=368.4128217pt height=49.73538075pt/></p>
These basis functions have been chosen so as to be already normalized.

In this basis, the problem becomes almost trivial:
<p align="center"><img src="/tex/132295f99071c92887c636369deed287.svg?invert_in_darkmode&sanitize=true" align=middle width=261.1920333pt height=49.315569599999996pt/></p>

to be solved for <img src="/tex/3343d1e4776a8c1cc78c3aa3e1c3c557.svg?invert_in_darkmode&sanitize=true" align=middle width=30.808809899999993pt height=14.15524440000002pt/> and where the source term is now

<p align="center"><img src="/tex/4ec3243c4b95787028f2d53b801683ad.svg?invert_in_darkmode&sanitize=true" align=middle width=447.1595766pt height=44.749102199999996pt/></p>

This two dimensional integral is the main computational work. For this you can
***and should*** use your `quadrature` module from assignment two. The number
of sample points for the quadrature ***does not*** need to be the same as the
number of samples for the Fourier coefficients. You may hard code the number
of quadrature sample points. If your quadrature subroutines are general enough
you just need to copy the `quadrature.f90` file into this repository and you
wont even need to make changes to the source code. However you will need to
modify the `makefile` in this repository to include the correct dependencies.

For the source term, we will use the function
<p align="center"><img src="/tex/59c9ff9b238c60d6db45edb314c713c8.svg?invert_in_darkmode&sanitize=true" align=middle width=343.05987539999995pt height=42.07871745pt/></p>

Your code should receive, via a `namelist` file given as an argument, the
following:

* The dimensions of the box, <img src="/tex/9dbcef13f3e6981dfe63f653112a933f.svg?invert_in_darkmode&sanitize=true" align=middle width=18.64161584999999pt height=22.465723500000017pt/> and <img src="/tex/ac6244c7cc0673f3a8d51603f75bcffe.svg?invert_in_darkmode&sanitize=true" align=middle width=18.26684969999999pt height=22.465723500000017pt/> (which may be different)
* The total charge <img src="/tex/3ee3f93b7a51e5719c84fadc68137817.svg?invert_in_darkmode&sanitize=true" align=middle width=15.05143034999999pt height=14.15524440000002pt/>.
* The center of the charge distribution <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/> and <img src="/tex/14adeddbb1889c9aba973ba30e7bce77.svg?invert_in_darkmode&sanitize=true" align=middle width=14.61197759999999pt height=14.15524440000002pt/>
* The widths <img src="/tex/baed07e6cbaba3e37ce167d64db1675d.svg?invert_in_darkmode&sanitize=true" align=middle width=19.935847799999987pt height=22.465723500000017pt/> and <img src="/tex/235409eac7aaaacd0cc98f7e38ea1ecd.svg?invert_in_darkmode&sanitize=true" align=middle width=19.561081649999988pt height=22.465723500000017pt/>
* The max index <img src="/tex/58a0abdbe1ebe952d7251c442f2dee8d.svg?invert_in_darkmode&sanitize=true" align=middle width=37.46589329999998pt height=22.465723500000017pt/>, which is the maximum value for both indices <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> and <img src="/tex/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode&sanitize=true" align=middle width=9.86687624999999pt height=14.15524440000002pt/>.

You may add additional `namelists` to the input file (e.g. name of the output
file, number of sample points for the quadrature, step size in each direction
when writing results for plots), just be sure to give default values to all
variables in all `namelists`.

Create a jupyter notebook to show your resulting potential <img src="/tex/f50853d41be7d55874e952eb0d80c53e.svg?invert_in_darkmode&sanitize=true" align=middle width=9.794543549999991pt height=22.831056599999986pt/> in a two
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