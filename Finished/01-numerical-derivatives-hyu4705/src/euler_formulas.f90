!-----------------------------------------------------------------------
!Module: euler_formulas
!-----------------------------------------------------------------------
!! By: Heng Yu
!!
!! Explain what are the functions and subroutines contained in this
!! module for
!!
!! This module gives two functions as euler 3 points and euler 5 points 
!! which are able to compute the second derivative of a function given from module analytic_functions.
!! they are both able to compute the result of second derivative but 5 points returns a more accurate result.
!!----------------------------------------------------------------------
!! Included functions:
!!
!! euler_3points(x,h)
!-----------------------------------------------------------------------
module euler_formulas
use types
use analytic_functions, only : analytic_f
implicit none

! The private statement restricts every function, parameter and variable
! defined in this module to be visible only by this module
private
! Then we use the public statement to only make visible to other modules 
! the few functions or subroutines that will be used by them
public euler_3points, euler_5points

contains

!-----------------------------------------------------------------------
!Function: euler_3points
!-----------------------------------------------------------------------
!! By: Heng Yu
!!
!! Explain what the function does and how it works
!!
!! This function computes the second derivative of the function by 3 points with central difference.
!! the basic method is use f'(x) = (f(x+h/2)-f(x-h/2))/h and f''(x) = (f'(x+h/2)-f'(x-h/2))/h 
!!----------------------------------------------------------------------
!! Arguments:
!!
!! x_zero   real    point x_0 at which to evaluate f''(x_0)
!! h_step   real    step size in the numerical expression
!-----------------------------------------------------------------------
!! Result:
!!
!! y_zero   real    (f(x+h)-2f(x)+f(x-h))/(h^2)
!-----------------------------------------------------------------------
function euler_3points(x_zero,h_step) result(y_zero)
    implicit none
    real(dp), intent(in) :: x_zero, h_step
    real(dp) :: y_zero
    real(dp) :: f_plus, f_zero, f_minus
    ! This evaluates the analytic function defined in the analytic_functions
    ! module at x+h, x, and x-h. Modify as you see necessary 
    f_plus = analytic_f(x_zero + h_step)
    f_zero = analytic_f(x_zero)
    f_minus = analytic_f(x_zero - h_step)

    ! Here you can use the evaluated values to calculate the numerical
    ! approximation to the second derivative
    y_zero = ( 1 / ( h_step ** 2 ) ) * ( f_plus - 2 * f_zero + f_minus )
end function euler_3points

! Don't forget to implement the 5 point formula for the advanced part of the project

!-----------------------------------------------------------------------
!Function: euler_5points
!-----------------------------------------------------------------------
!! Arguments:
!!
!! x_zero   real    point x_0 at which to evaluate f''(x_0)
!! h_step   real    step size in the numerical expression
!-----------------------------------------------------------------------
!! Result:
!!
!! y_zero   real    (-f(x+2h)+16f(x+h)-30f(x)+16f(x-h)-f(x-2h))/(12h^2)
!-----------------------------------------------------------------------
function euler_5points(x_zero,h_step) result(y_zero)
    implicit none

    ! here I take the input value x_zero and h from user. result y_zero and five functions from 5 point.
    real(dp), intent(in) :: x_zero, h_step
    real(dp) :: y_zero
    real(dp) :: f_plus2, f_plus, f_zero, f_minus, f_minus2
    
    ! This is the meaning of functions of five point 
    f_plus2 = analytic_f(x_zero + 2 * h_step)
    f_plus = analytic_f(x_zero + h_step)
    f_zero = analytic_f(x_zero)
    f_minus = analytic_f(x_zero - h_step)
    f_minus2 = analytic_f(x_zero - 2 * h_step)
    
    ! result y_zero is given from the README.md
    y_zero = (1 / (12 * (h_step ** 2))) * ( (-1) * f_plus2 + 16 * f_plus - 30 * f_zero + 16 * f_minus - f_minus2)
    
end function euler_5points
    
end module euler_formulas