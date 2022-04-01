!!-----------------------------------------------------------------------
!! Program: poisson_potential
!!-----------------------------------------------------------------------
!! By: 
!!
!! Explain what the program does
!!
!!-----------------------------------------------------------------------
program poisson_potential

use types
use read_write, only : read_input, write_potential, print_wall_clock_time
use potential, only : calculate_coefficients

implicit none

real(dp) :: length(1:2)
real(dp) :: rho_zero, center(1:2), width(1:2)
integer :: n_max

integer :: count_1, count_2, count_rate, count_max

real(dp), allocatable :: c_fourier(:,:)


call system_clock(count_1, count_rate, count_max)

call read_input(length, rho_zero, center, width, n_max)
call calculate_coefficients(length, rho_zero, center, width, n_max, c_fourier)
call write_potential()

call system_clock(count_2, count_rate, count_max)

call print_wall_clock_time(count_1, count_2, count_rate)


end program poisson_potential