
# Numerical Derivatives (Euler Method)

## Important Considerations

This project will be weighted at 0.5 relative to other projects.

**The drop deadline is Monday September 9, 2019**. The main purpose of this
project is for you to self-test whether you have the appropriate skills for this
course. You should find this project easy; if not, you should strongly
consider dropping the course. Of course, just because you find this project
is easy doesn't mean you will find all projects easy.

### Set up and submission

We will follow the GitHub work-flow.

First you need to get a copy of this
repository in your local machine. For that you'll need to use the command
```
git clone <your repo address>
```
You can find (and copy to your clipboard) the repo address in the big green
button that says "Code" and has an arrow pointing down.
Do not include the `< >` brackets in your command

After that you should have a copy of this `README.md` file and the starter
code in your own computer. The next step is to create a new branch for you to 
work on your local machine. For that you can use 
```
git checkout -b new_branch
```
You can replace `new_branch` with whatever name you want. For example you can
call it `first_attempt`. The next step is for that branch to exist on your
remote repository (the one on [GitHub.com](github.com)). For that you can use
```
git push --set-upstream origin new_branch
```
You do need to use the word `origin` but instead of `new_branch` use whatever
name you used in the previous command. 

Now you are all set up to start working on your code. Every time you reach a
different milestone (e.g. you implemented a new function, you found and fixed
a bug, etc) make sure to do a commit and push it as we saw in class. This will
show me your progress over time and will let me know whether you've worked on
your assignment over time or if you decided to do everything at the last
minute. Do not include in your commits any temporary files (`.mod` and `.o`
files generated during compilation) or output files (`results.dat`). Your
remote repository should only contain README files and source code files.

Once your code is ready for submission (and after you have made your final
commit and push) got to the repository on [GitHub.com](github.com) and use the
pull request feature clicking on the "compare and pull request" green button
on the homepage of your repository. There you can put me as a Reviewer, that
will let me know you're assignment is ready to be graded.

For the first three projects I will use the pull request feature to provide
you with detailed feedback.  Note that this is not a license to submit an
incomplete project. If you submit a project without graphs, you will not get
credit for submitting a 'final' graph. If your code is not working, your final
project will reflect that fact. The purpose of feedback is to give you
guidance on how the code should interact with the user and to improve your
plots, not give you more time to submit them.

## Assignment

In order to help you with this assignment a starter code is included in this 
repository. Although the starter code compiles using the command `make` it
does not produce the expected output. You need to modify the current code in
order to perform the tasks outlined below.

Consider the function $f(x) = x \sin(x)$

## Basic Project (worth 70%)

Using the symmetric 3-point formula discussed in class, compute the numerical
second derivative $f''(x_0)$. Your code should ask the user for any value of
$x_0$.

Your code should also write into a file called `results.dat` the analytic and
numerical derivatives as a function of the step size $dx$ for a given $x_0$. Of
course, the analytic formula is constant for any $dx$.

For $x_0$, use the first letter of your last name (A=1.0, B = 2.0, etc.).
Choose a reasonable range for $dx$. I'll leave out to you figure out what is a
*reasonable* range for $dx$

Using the jupyter notebook provided in the starter code you need to read the
output from your fortran code and make a log-log plot of the error of the
numerical derivative  as a function of $dx$


## Advanced Project (worth 20%)

Modify the fortran code and jupyter notebook to also include a calculation of
the second derivative using the symmetric 5-points formula. Plot together the 
3-points and 5-points results as a function of $dx$ on your graph.


## Expert Project (worth 10%)

Using the linear regression tool `linregress` implemented in `scipy.stats` and
following the corresponding documentation, find the power law dependence for
the error as a function of $dx$. Is it what you expect?


## General Notes

For full credit on all parts, your program should be well-commented, and input
and output clear and easy to use. The ideal program will have separate
functions for the 3-point and 5-point formulas. 

The symmetric three-point formula is:
$$
f''(x) \approx \frac{f(x+h)-2f(x)+f(x-h)}{h^2} + O(h^2).
$$

The symmetric five-point formula is:
$$
f''(x) \approx \frac{-f(x+2h)+16f(x+h)-30f(x)+16f(x-h)-f(x-2h)}{12h^2} + O(h^4).
$$

The notation $O(h^n)$ means "the error is of *the order of* $h^n$" and is
standard notation, although you might not have encountered it before. It is
*not* part of the derivative formulas. Instead, the goal of this project is to
show, for example, that **for some range** of $h$, that $f''_{\rm exact}(x) -
f''_{\rm num}(x)\ \propto h^n$, where $f''_{\rm exact}$ means the analytic
second derivative and $f''_{\rm num}$ means one of the numerical formulas
above. On a log-log plot, a power law (like $h^n$) should look linear. The
hint **some range of h** I leave for you to discover and interpret.