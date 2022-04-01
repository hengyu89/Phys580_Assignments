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

<p align="center"><img src="/tex/4552ba0f714af2bd7ae7e74d14efdbe8.svg?invert_in_darkmode&sanitize=true" align=middle width=312.3338559pt height=18.905967299999997pt/></p>

where <img src="/tex/fdc2e930539279257e74e396b1b19e5f.svg?invert_in_darkmode&sanitize=true" align=middle width=61.00841009999999pt height=24.65753399999998pt/> is the mass of the nucleus, <img src="/tex/6d5244e4487392d89951c16e9448b3a6.svg?invert_in_darkmode&sanitize=true" align=middle width=21.209578499999992pt height=14.15524440000002pt/> is the mass of the proton,
<img src="/tex/d595c5e155ed3536b61bbc92e8faf975.svg?invert_in_darkmode&sanitize=true" align=middle width=22.559123399999994pt height=14.15524440000002pt/> is the mass of the neutron, <img src="/tex/3e18a4a28fdee1744e5e3f79d13b9ff6.svg?invert_in_darkmode&sanitize=true" align=middle width=7.11380504999999pt height=14.15524440000002pt/> is the speed of light and <img src="/tex/9dbbc2ae23039c450a0da078fc22bfc2.svg?invert_in_darkmode&sanitize=true" align=middle width=72.95089064999999pt height=24.65753399999998pt/> is
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

<p align="center"><img src="/tex/0223f7931d4789a2cf2feed14bd06c32.svg?invert_in_darkmode&sanitize=true" align=middle width=617.91025065pt height=36.07218285pt/></p>

where <img src="/tex/43a97efd034fec64f0881b6e81804763.svg?invert_in_darkmode&sanitize=true" align=middle width=81.73488014999998pt height=22.465723500000017pt/> is the *mass number*, and <img src="/tex/5871887b30b49a0c6000a0dc659187c3.svg?invert_in_darkmode&sanitize=true" align=middle width=84.64022159999999pt height=24.65753399999998pt/> if <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/> and <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/> are
both even, <img src="/tex/a1bcfa0b785155b4d163ad8bb13b6f4f.svg?invert_in_darkmode&sanitize=true" align=middle width=38.35617554999999pt height=21.18721440000001pt/> if <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/> and <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/> are both odd, and <img src="/tex/1c4e4df490c6d0cf92fc90533df5f31e.svg?invert_in_darkmode&sanitize=true" align=middle width=25.570741349999988pt height=21.18721440000001pt/> if <img src="/tex/53d147e7f3fe6e47ee05b88b166bd3f6.svg?invert_in_darkmode&sanitize=true" align=middle width=12.32879834999999pt height=22.465723500000017pt/> is odd.

The Atomic Mass Evaluation (AME) has compiled the most up to date value of all
measured binding energies. You can find them in the `EXPERIMENT_AME2016.dat`
file. The goal in this assignment is to determine the parameters <img src="/tex/c99cad76c463360165265bc03aa019a9.svg?invert_in_darkmode&sanitize=true" align=middle width=23.940381299999988pt height=14.15524440000002pt/>, <img src="/tex/31291577b6116dc9e26b5337780549ba.svg?invert_in_darkmode&sanitize=true" align=middle width=29.71327589999999pt height=14.15524440000002pt/>, etc that best describe the experimental data and use
those parameters to identify the position of the neutron dripline.

### Basic Project: Best parameters (worth 60%)

As we saw in class, the best fit parameters from the linear model (like the
semi-empirical mass formula above) can be determined by solving a set of
linear equations, which in turn can be represented as a matrix equation

<p align="center"><img src="/tex/f28132571410f75dda8df999711902f5.svg?invert_in_darkmode&sanitize=true" align=middle width=65.58763529999999pt height=19.278557099999997pt/></p>
<p align="center"><img src="/tex/477ca166f599d7df0a586d76859d7631.svg?invert_in_darkmode&sanitize=true" align=middle width=222.52083315pt height=48.18280005pt/></p>
<p align="center"><img src="/tex/b636944434927dfff78b4d85395e9591.svg?invert_in_darkmode&sanitize=true" align=middle width=246.48583739999998pt height=48.18280005pt/></p>

where <img src="/tex/19e3f7018228f8a8c6559d0ea5500aa2.svg?invert_in_darkmode&sanitize=true" align=middle width=10.747741949999991pt height=23.488575000000026pt/> contains the parameters in the linear model, <img src="/tex/8175b4b012861c57d7f99a503fdcaa72.svg?invert_in_darkmode&sanitize=true" align=middle width=21.27105584999999pt height=14.15524440000002pt/> are
the matrix elements of <img src="/tex/c745b9b57c145ec5577b82542b2df546.svg?invert_in_darkmode&sanitize=true" align=middle width=10.57650494999999pt height=14.15524440000002pt/>, <img src="/tex/3d13090ef3ed1448f3c4dc166d06ab4d.svg?invert_in_darkmode&sanitize=true" align=middle width=13.948864049999989pt height=22.831056599999986pt/> are the elements of the vector
<img src="/tex/c90119f20c10a72dd5dccbfc89cd0785.svg?invert_in_darkmode&sanitize=true" align=middle width=11.826559799999991pt height=32.16441360000002pt/>, <img src="/tex/fb97d38bcc19230b0acd442e17db879c.svg?invert_in_darkmode&sanitize=true" align=middle width=17.73973739999999pt height=22.465723500000017pt/> is the number experimental values, the functions
<img src="/tex/60a1ae0f915e254cd583eb8c73da83d6.svg?invert_in_darkmode&sanitize=true" align=middle width=74.21723594999997pt height=24.65753399999998pt/> are the ones multiplying each of the linear parameters in the
semi-empirical mass formula, <img src="/tex/4f3c8dba495759e957a624e67fced894.svg?invert_in_darkmode&sanitize=true" align=middle width=106.95801599999999pt height=24.65753399999998pt/> is the experimental value
of each binding energy,  and <img src="/tex/22d241353c49e91d51aaca9620ad7fa1.svg?invert_in_darkmode&sanitize=true" align=middle width=16.659135899999992pt height=14.15524440000002pt/> is the corresponding experimental
error.

In this case <img src="/tex/c745b9b57c145ec5577b82542b2df546.svg?invert_in_darkmode&sanitize=true" align=middle width=10.57650494999999pt height=14.15524440000002pt/> is a <img src="/tex/2327f488710138e6e27dd6a99f49414c.svg?invert_in_darkmode&sanitize=true" align=middle width=36.52961069999999pt height=21.18721440000001pt/> matrix because the semi-empirical mass
formula has 5 parameters, <img src="/tex/8915548352c05130dfea9dd1ab873e35.svg?invert_in_darkmode&sanitize=true" align=middle width=23.940381299999988pt height=14.15524440000002pt/>, <img src="/tex/31291577b6116dc9e26b5337780549ba.svg?invert_in_darkmode&sanitize=true" align=middle width=29.71327589999999pt height=14.15524440000002pt/>, <img src="/tex/594fd118d901d67c2c6be43f2c03cdc1.svg?invert_in_darkmode&sanitize=true" align=middle width=36.579727799999986pt height=14.15524440000002pt/>,
<img src="/tex/b973aff2314ebf28d245216da5cd52a8.svg?invert_in_darkmode&sanitize=true" align=middle width=34.03175654999999pt height=14.15524440000002pt/>, and <img src="/tex/13142c64f0a99953f5ce0644c467793d.svg?invert_in_darkmode&sanitize=true" align=middle width=29.78516474999999pt height=14.15524440000002pt/>.

Furthermore, the inverse of the <img src="/tex/c745b9b57c145ec5577b82542b2df546.svg?invert_in_darkmode&sanitize=true" align=middle width=10.57650494999999pt height=14.15524440000002pt/> matrix corresponds to the covariance
matrix <img src="/tex/c82fc5d3dd5ce76f9e830892b72c70a9.svg?invert_in_darkmode&sanitize=true" align=middle width=62.24533424999999pt height=26.76175259999998pt/>. In certain cases the covariance matrix can be used
to propagate the experimental uncertainty to any quantity calculated with the
model parameters <img src="/tex/19e3f7018228f8a8c6559d0ea5500aa2.svg?invert_in_darkmode&sanitize=true" align=middle width=10.747741949999991pt height=23.488575000000026pt/>. If <img src="/tex/3cf4fbd05970446973fc3d9fa3fe3c41.svg?invert_in_darkmode&sanitize=true" align=middle width=8.430376349999989pt height=14.15524440000002pt/> is a function that depends on the
parameters <img src="/tex/9fc20fb1d3825674c6a279cb0d5ca636.svg?invert_in_darkmode&sanitize=true" align=middle width=14.045887349999989pt height=14.15524440000002pt/>, the propagated uncertainty is given by

<p align="center"><img src="/tex/f72676ee058ec3178e32217bb204719c.svg?invert_in_darkmode&sanitize=true" align=middle width=225.43650524999998pt height=45.46828935pt/></p>

Your code should do the following:

1. Ask for the name of the input file with the experimental data and read the experimental data
2. Construct the <img src="/tex/8175b4b012861c57d7f99a503fdcaa72.svg?invert_in_darkmode&sanitize=true" align=middle width=21.27105584999999pt height=14.15524440000002pt/> matrix and <img src="/tex/3d13090ef3ed1448f3c4dc166d06ab4d.svg?invert_in_darkmode&sanitize=true" align=middle width=13.948864049999989pt height=22.831056599999986pt/> vector
3. Use the already provided subroutines for LU decomposition to invert the <img src="/tex/c745b9b57c145ec5577b82542b2df546.svg?invert_in_darkmode&sanitize=true" align=middle width=10.57650494999999pt height=14.15524440000002pt/> matrix
4. Use the inverse matrix to solve the system <img src="/tex/50291b82c22714705dbf769477649fd0.svg?invert_in_darkmode&sanitize=true" align=middle width=65.58763529999999pt height=32.16441360000002pt/>
5. Print to screen the best fit parameters with its corresponding uncertainties.
5. Write a file containing the experimental values, experimental uncertainties, theoretical values and theoretical uncertainties.

### Advanced Project: Neutron dripline and Shell structure.

#### Part I (worth 20%)

Now that you have a theoretical model to calculate the binding energy of any
isotope determined by <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/> and <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/> you can use that model to make predictions. 

Write a subroutine that for every value of <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/> between 1 and 118 finds the
most stable isotope. That is, the value of <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/> for which the binding energy
**per nucleon** is the lowest (i.e. the largest negative). This is sometimes
referred as *the valley of stability*

The neutron drip-line is defined as the maximum values of <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/> which correspond
to bound nuclei, for a given <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/>, that is for which the 1 neutron separation
energy <img src="/tex/cb269092af4402bbbe23e066db53ae83.svg?invert_in_darkmode&sanitize=true" align=middle width=265.3857046499999pt height=24.65753399999998pt/>.

Write another subroutine that for every value of <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/> between 1 and 118 finds
the position of the neutron drip-line. That is, the largest value of <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/> for
which the separation energy <img src="/tex/49aebd2501b0bf3a5225ca26ba123672.svg?invert_in_darkmode&sanitize=true" align=middle width=18.205948199999987pt height=22.465723500000017pt/> is positive. 

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

Make two more plots. One for the experimental uncertainty as a function of <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/>
and one of your calculated theoretical uncertainties as a function of <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/>.
You'll probably see that your theoretical uncertainties are **much** smaller
of the experimental ones. Discuss why in the notebook 

### Super fun extra credit: Improve the semi-empirical mass formula (worth 10%)

Modify your FORTRAN code and invent your own term for the semi-empirical
formula, some function of <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/> and <img src="/tex/f9c4988898e7f532b9f826a75014ed3c.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=22.465723500000017pt/>, say <img src="/tex/c0e67bbb86b92e240cb5303c839f8143.svg?invert_in_darkmode&sanitize=true" align=middle width=65.59369079999998pt height=24.65753399999998pt/> (Do not copy anyone
else's term). Use the jupyter notebook to compute the reduced <img src="/tex/a67d576e7d59b991dd010277c7351ae0.svg?invert_in_darkmode&sanitize=true" align=middle width=16.837900199999993pt height=26.76175259999998pt/> for
your data set, that is,

<p align="center"><img src="/tex/f4565d4e008043e8bdea7b0149ec35b3.svg?invert_in_darkmode&sanitize=true" align=middle width=375.6511275pt height=47.806078649999996pt/></p>

where <img src="/tex/d6328eaebbcd5c358f426dbea4bdbf70.svg?invert_in_darkmode&sanitize=true" align=middle width=15.13700594999999pt height=22.465723500000017pt/> is the number of parameters, <img src="/tex/fb97d38bcc19230b0acd442e17db879c.svg?invert_in_darkmode&sanitize=true" align=middle width=17.73973739999999pt height=22.465723500000017pt/> the number of experimental data and
<img src="/tex/f45541603e6edb172c23dac0cf3e69c6.svg?invert_in_darkmode&sanitize=true" align=middle width=52.96791224999998pt height=22.465723500000017pt/> is known as the *degrees of freedom*. Note that the original model had
<img src="/tex/b0da3d297bbd326b47d166c182dc6290.svg?invert_in_darkmode&sanitize=true" align=middle width=45.273840149999984pt height=22.465723500000017pt/>, but your knew model will have <img src="/tex/49b0b4f69e52d988845a47c48a1f58c9.svg?invert_in_darkmode&sanitize=true" align=middle width=45.273840149999984pt height=22.465723500000017pt/>. The person who submits an improved
binding energy formula with the best verifiable (by me) improvement in reduced
<img src="/tex/a67d576e7d59b991dd010277c7351ae0.svg?invert_in_darkmode&sanitize=true" align=middle width=16.837900199999993pt height=26.76175259999998pt/> will get an additional 10% credit!

## General Notes


For full credit on all parts, your program should be well-commented, and input
and output clear and easy to use.