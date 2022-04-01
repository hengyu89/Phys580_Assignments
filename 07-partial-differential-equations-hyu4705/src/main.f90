! Program: schrodinger
! By: 
!-----------------------------------------------------------------------------
! Give an explanation of what the code does.
!-----------------------------------------------------------------------------
program schrodinger 

use types
use read_write, only : read_input, write_time_evolution, write_expectation_values
use quantum, only : sample_box, construct_initial_wavefunction, construct_time_evolution_matrix, &
    evolve_wave_function, expectation_values

implicit none

real(dp) :: length, delta_t, width, center, k_oscillator
integer :: n_points, n_steps
character(len=1024) :: time_file, density_file 
real(dp), allocatable :: x_vector(:) !will be of size n_points.
real(dp), allocatable :: wave_function(:)! will be of size 2*n_points.
real(dp), allocatable :: evolution_matrix(:,:) !will be of size 2*n_points by 2*n_points
real(dp), allocatable :: time_wave_function(:,:) !will be of size n_points by n_steps + 1 (the +1 is so that you can store the t=0 value)
real(dp), allocatable :: norm(:), postion(:), sigma(:) !all of size n_steps + 1 

call read_input(length, n_points, n_steps, delta_t, width, center, k_oscillator, time_file, density_file)
! call sample_box()
! call construct_initial_wavefunction()
! call construct_time_evolution_matrix()
! call evolve_wave_function()
! call expectation_values()
! call write_time_evolution()
! call write_expectation_values()

end program schrodinger