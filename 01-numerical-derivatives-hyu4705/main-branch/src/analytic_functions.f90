!-----------------------------------------------------------------------
!Module: analytic_functions
!-----------------------------------------------------------------------
!! By:
!!
!! Explain what are the functions and subroutines contained in this
!! module for
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
    !! By: 
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
        y_zero = 0._dp
    end function analytic_f
    
    !-----------------------------------------------------------------------
    !Function: second_derivative_f
    !-----------------------------------------------------------------------
    !! By:
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
        y_zero = 0._dp
    end function second_derivative_f
        
    end module analytic_functions