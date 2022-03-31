!-----------------------------------------------------------------------
!Module: euler_formulas
!-----------------------------------------------------------------------
!! By:
!!
!! Explain what are the functions and subroutines contained in this
!! module for
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
    public euler_3points
    
    contains
    
    !-----------------------------------------------------------------------
    !Function: euler_3points
    !-----------------------------------------------------------------------
    !! By: 
    !!
    !! Explain what the function does and how it works
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
        f_zero = 0._dp
        f_minus = 0._dp
    
        ! Here you can use the evaluated values to calculate the numerical
        ! approximation to the second derivative
        y_zero = 0._dp
    end function euler_3points
    
    ! Don't forget to implement the 5 point formula for the advanced part of the project
        
    end module euler_formulas