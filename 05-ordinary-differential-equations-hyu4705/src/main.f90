! Program: planets
! By: 
!-----------------------------------------------------------------------------
!-----------------------------------------------------------------------------
program planets

use types
use read_write, only : read_input, write_results
use ode_solver, only : solve_runge_kutta_4
use mechanics, only : calculate_energy

implicit none

real(dp) :: work_array(1:3), initial_condition(1:8)
real(dp) :: final_time
integer :: n_steps
real(dp), allocatable :: time(:), solution(:,:), energy(:)
character(len=1024) :: output_file

! call read_input()

! call solve_runge_kutta_4()
! call calculate_energy()

! call write_results()


end program planets