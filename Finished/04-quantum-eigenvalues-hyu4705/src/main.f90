!-----------------------------------------------------------------------------
!! Program: schrodinger_solution
!! Heng Yu
!!
!! The program will calculate the ground, 1st excited and 3nd excited normalized 
!! probability densities in infinite well/harmonic oscillator/woods saxon and 
!! stores them into .dat files. And also stores three lowest energies for the 
!! Woods-Saxon potential then graphs all of those database.  
!!
!! The program will ask for the input of length of box L, radius of Woods Saxon 
!! potential R and number of points n for slices of box the user would like to separate.
!-----------------------------------------------------------------------------
program schrodinger_solution 

use types
use read_write, only : read_input, write_probability_density, print_energies, write_woods_saxon_energies
use qm_solver, only: sample_box, solve_infinite_well, analytic_infinite_well, solve_harmonic_oscillator,&
    analytic_harmonic_oscillator, solve_woods_saxon
implicit none

integer :: n_points
real(dp) :: length, radius

integer, parameter :: n_energies = 3
real(dp) :: energies(1:n_energies), analytic_energies(1:n_energies)
real(dp), allocatable :: wave_functions(:,:)
real(dp), allocatable :: x_vector(:)
real(dp), parameter :: r_min = 2._dp, r_max = 10._dp

call read_input(n_points, length, radius)                                                               !! Returns n_points, length, radius.

call sample_box(length, n_points, x_vector)                                                             !! Returns x_vector.

! Solving particle in a box
call solve_infinite_well(n_points, length, x_vector, wave_functions, energies)                  !! Returns energies, wave_functions.
call analytic_infinite_well(length, analytic_energies)
call print_energies('Infinite Well', energies, analytic_energies)
call write_probability_density('infinite_well_wf.dat', x_vector, wave_functions)

! Solving harmonic oscillator
call solve_harmonic_oscillator(n_points, length, x_vector, wave_functions, energies)
call analytic_harmonic_oscillator(analytic_energies)
call print_energies('Harmonic oscillator', energies, analytic_energies)
call write_probability_density('harmonic_oscillator_wf.dat', x_vector, wave_functions)

! Solving Woods Saxon
call solve_woods_saxon(n_points, length, radius, x_vector, wave_functions, energies)
call write_probability_density('woods_saxon_wf.dat', x_vector, wave_functions)

! Woods Saxon Energies as a function of radius
call write_woods_saxon_energies('woods_saxon_ener.dat', n_points, x_vector, length, r_min, r_max)

end program schrodinger_solution