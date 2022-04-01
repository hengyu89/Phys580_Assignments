program ftcs_example

use types
use ode_solver, only : solve_euler
use pde_solver, only : heat_equation, wave_equation
use read_write, only : write_heat_results, write_wave_results
implicit none

real(dp), parameter :: final_time = 100._dp
integer, parameter :: n_steps = 4000
real(dp), parameter :: length = 10._dp
integer, parameter :: n_samples = 100
real(dp), parameter :: diffusivity = 0.1_dp

real(dp) :: delta_x
real(dp) :: work_array(1:2)
real(dp) :: temperature(1:n_samples)

real(dp) :: omega = 2.0_dp
real(dp) :: string(1:2*n_samples)

real(dp), allocatable :: time(:), solution(:,:)
integer :: i, j 

delta_x = length/(n_samples-1._dp)

temperature = 20._dp
temperature(1) = 100._dp
temperature(n_samples) = -20._dp

work_array(1) = diffusivity
work_array(2) = delta_x

call solve_euler(heat_equation, work_array, final_time, n_steps &
    , temperature, time, solution)

call write_heat_results(solution)

work_array(1) = omega
work_array(2) = delta_x

! initial conditions. A guitar string is pulled from the middle
do i = 1, n_samples/2
    j = n_samples+1-i
    string(i) = (i-1)*delta_x*.1
    string(j) = (i-1)*delta_x*.1
enddo

! The string is released from rest (velocity is zero)
string(n_samples + 1: 2*n_samples) = 0._dp

call solve_euler(wave_equation, work_array, final_time, n_steps &
    , string, time, solution)

call write_wave_results(solution)

end program ftcs_example

