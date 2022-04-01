!-----------------------------------------------------------------------
!Module: analytic_functions
!-----------------------------------------------------------------------
!! By:Heng Yu
!!
!! Explain what are the functions and subroutines contained in this
!! module for
!!
!! This module gives two functions which are normal and second derivative functions of x*sin(x).
!!----------------------------------------------------------------------
!! Included functions:
!!
!! analytic_f(x)
!! second_derivative_f(x)
!-----------------------------------------------------------------------
module analytic_functions
use types
implicit none

! The private statement restricts every function, parameter and variable
! defined in this module to be visible only by this module
private
! Then we use the public statement to only make visible to other modules 
! the few functions or subroutines that will be used by them
public analytic_f, second_derivative_f

contains

!-----------------------------------------------------------------------
!Function: analytic_f
!-----------------------------------------------------------------------
!! By: The analytic function uses for computing the result of function x*sin(x) 
!!     by putting the x value into the function.
!!
!!     And the function take the input value by user as x_zero. set y_zero as a real number
!!     then take the result of x * sin(x). 
!!
!! Explain what the function does and how it works
!!----------------------------------------------------------------------
!! Arguments:
!!
!! x_zero	real	point x_0 at which to evaluate f(x_0)
!-----------------------------------------------------------------------
!! Result:
!!
!! y_zero	real	x_0 sin(x_0)
!-----------------------------------------------------------------------
function analytic_f(x_zero) result(y_zero)
    implicit none
    real(dp), intent(in) :: x_zero
    real(dp) :: y_zero
    ! This one is pretty easy. The function should return
    ! x*sin(x)
    y_zero = x_zero*sin(x_zero)
end function analytic_f

!-----------------------------------------------------------------------
!Function: second_derivative_f
!-----------------------------------------------------------------------
!! By: Similar as previous function. This function gives the second derivative of function x*sin(x).
!!     by the way, the first derivative of original function is sin(x)+x*cos(x).
!!
!!     It takes input of x_zero given by user and directly computs the result of second derivative
!!     written by me.
!!
!! Explain what the function does and how it works
!!----------------------------------------------------------------------
!! Arguments:
!!
!! x_zero	real	point x_0 at which to evaluate f''(x_0)
!-----------------------------------------------------------------------
!! Result:
!!
!! y_zero	real	
!-----------------------------------------------------------------------
function second_derivative_f(x_zero) result(y_zero)
    implicit none
    real(dp), intent(in) :: x_zero
    real(dp) :: y_zero
    ! You need to code the analytic expression for 
    ! the second derivative of x*sin(x) and store it in y_zero
    y_zero = 2 * cos(x_zero) - x_zero * sin(x_zero)
end function second_derivative_f
    
end module analytic_functions
