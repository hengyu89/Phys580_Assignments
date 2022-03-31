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

Consider the function <img src="/tex/4884ca36a6bf29c95c0bbb336d3ffbc5.svg?invert_in_darkmode&sanitize=true" align=middle width=108.41322029999999pt height=24.65753399999998pt/>

## Basic Project (worth 70%)

Using the symmetric 3-point formula discussed in class, compute the numerical
second derivative <img src="/tex/3713e9b8c9ed64d956bd068a2c3de13b.svg?invert_in_darkmode&sanitize=true" align=middle width=47.77412639999999pt height=24.7161288pt/>. Your code should ask the user for any value of
<img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/>.

Your code should also write into a file called `results.dat` the analytic and
numerical derivatives as a function of the step size <img src="/tex/74380e4b90b7786c87c490f3d94f2f68.svg?invert_in_darkmode&sanitize=true" align=middle width=17.95095224999999pt height=22.831056599999986pt/> for a given <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/>. Of
course, the analytic formula is constant for any <img src="/tex/74380e4b90b7786c87c490f3d94f2f68.svg?invert_in_darkmode&sanitize=true" align=middle width=17.95095224999999pt height=22.831056599999986pt/>.

For <img src="/tex/e714a3139958da04b41e3e607a544455.svg?invert_in_darkmode&sanitize=true" align=middle width=15.94753544999999pt height=14.15524440000002pt/>, use the first letter of your last name (A=1.0, B = 2.0, etc.).
Choose a reasonable range for <img src="/tex/74380e4b90b7786c87c490f3d94f2f68.svg?invert_in_darkmode&sanitize=true" align=middle width=17.95095224999999pt height=22.831056599999986pt/>. I'll leave out to you figure out what is a
*reasonable* range for <img src="/tex/74380e4b90b7786c87c490f3d94f2f68.svg?invert_in_darkmode&sanitize=true" align=middle width=17.95095224999999pt height=22.831056599999986pt/>

Using the jupyter notebook provided in the starter code you need to read the
output from your fortran code and make a log-log plot of the error of the
numerical derivative  as a function of <img src="/tex/74380e4b90b7786c87c490f3d94f2f68.svg?invert_in_darkmode&sanitize=true" align=middle width=17.95095224999999pt height=22.831056599999986pt/>


## Advanced Project (worth 20%)

Modify the fortran code and jupyter notebook to also include a calculation of
the second derivative using the symmetric 5-points formula. Plot together the 
3-points and 5-points results as a function of <img src="/tex/74380e4b90b7786c87c490f3d94f2f68.svg?invert_in_darkmode&sanitize=true" align=middle width=17.95095224999999pt height=22.831056599999986pt/> on your graph.


## Expert Project (worth 10%)

Using the linear regression tool `linregress` implemented in `scipy.stats` and
following the corresponding documentation, find the power law dependence for
the error as a function of <img src="/tex/74380e4b90b7786c87c490f3d94f2f68.svg?invert_in_darkmode&sanitize=true" align=middle width=17.95095224999999pt height=22.831056599999986pt/>. Is it what you expect?


## General Notes

For full credit on all parts, your program should be well-commented, and input
and output clear and easy to use. The ideal program will have separate
functions for the 3-point and 5-point formulas. 

The symmetric three-point formula is:
<p align="center"><img src="/tex/e94c1c5f5722264aad2731071e6df3d2.svg?invert_in_darkmode&sanitize=true" align=middle width=337.06588574999995pt height=34.7253258pt/></p>

The symmetric five-point formula is:
<p align="center"><img src="/tex/5505e82ebef7bbc6794b875797283886.svg?invert_in_darkmode&sanitize=true" align=middle width=570.688272pt height=34.7253258pt/></p>

The notation <img src="/tex/17dfb8c7b144d9b7ee130b3089ac7d26.svg?invert_in_darkmode&sanitize=true" align=middle width=44.199911249999985pt height=24.65753399999998pt/> means "the error is of *the order of* <img src="/tex/eb1848d8e7b88b35cb23249e33bfb841.svg?invert_in_darkmode&sanitize=true" align=middle width=17.59713779999999pt height=22.831056599999986pt/>" and is
standard notation, although you might not have encountered it before. It is
*not* part of the derivative formulas. Instead, the goal of this project is to
show, for example, that **for some range** of <img src="/tex/2ad9d098b937e46f9f58968551adac57.svg?invert_in_darkmode&sanitize=true" align=middle width=9.47111549999999pt height=22.831056599999986pt/>, that <img src="/tex/07eb74e4a4e46fc561afc96de9f32b0e.svg?invert_in_darkmode&sanitize=true" align=middle width=182.43745409999997pt height=24.7161288pt/>, where <img src="/tex/9c6deb9510605a378635dd9861f023ad.svg?invert_in_darkmode&sanitize=true" align=middle width=38.33355404999999pt height=24.7161288pt/> means the analytic
second derivative and <img src="/tex/452c617de78d45aaa314e3fd117a614b.svg?invert_in_darkmode&sanitize=true" align=middle width=33.01385504999999pt height=24.7161288pt/> means one of the numerical formulas
above. On a log-log plot, a power law (like <img src="/tex/eb1848d8e7b88b35cb23249e33bfb841.svg?invert_in_darkmode&sanitize=true" align=middle width=17.59713779999999pt height=22.831056599999986pt/>) should look linear. The
hint **some range of h** I leave for you to discover and interpret.