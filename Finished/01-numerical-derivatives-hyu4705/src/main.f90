! Program: numerical_derivatives
! By: Heng Yu
!-----------------------------------------------------------------------------
!
! Calculates the second derivative of f(x) = x sin(x) using Euler's method.
! ... expand your documentation of your code. How does the program work?
!
!-----------------------------------------------------------------------------
program numerical_derivatives
use types 
use read_write

implicit none
real(dp) :: x_zero

! the dp inside of the real(dp) declaration was defined in the types module
! and allows to use reals with double precision 
call read_input(x_zero)
call write_derivatives(x_zero)


end program numerical_derivatives