!!-----------------------------------------------------------------------
!! Program: poisson_potential
!!-----------------------------------------------------------------------
!! By: Noah Egger
!!
!! This program solves Poisson's equation within a conducting box and
!! obtains the electrostatic potential as a function of position x,y
!! within the box.
!!
!!-----------------------------------------------------------------------
program poisson_potential

use types
use read_write, only : read_input, write_potential, print_wall_clock_time
use potential, only : calculate_coefficients

implicit none

real(dp) :: length(1:2)
real(dp) :: rho_zero, center(1:2), width(1:2)
integer :: n_max, n_samples, num_threads
character(len = 1024) :: file_name
character(len = 1024) :: time_file_name
logical :: run_write_wall_clock

integer :: count_1, count_2, count_rate, count_max

real(dp), allocatable :: c_fourier(:,:)

call system_clock(count_1, count_rate, count_max)

call read_input(length, rho_zero, center, width, n_max, n_samples, file_name)
call calculate_coefficients(length, rho_zero, center, width, n_max, n_samples, c_fourier)
call write_potential(c_fourier, length, file_name)

call system_clock(count_2, count_rate, count_max)

call print_wall_clock_time(count_1, count_2, count_rate)

end program poisson_potential