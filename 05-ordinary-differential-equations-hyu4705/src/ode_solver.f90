!-----------------------------------------------------------------------
!Module: ode_solver
!-----------------------------------------------------------------------
!! By:
!!
!!----------------------------------------------------------------------
!! Included subroutines:
!!
!!----------------------------------------------------------------------
!! Included functions:
!!
!-----------------------------------------------------------------------
module ode_solver
use types
implicit none
private

public :: solve_runge_kutta_4

interface
    function func(r, t, work) result(f)
        !.....
    end function func
end interface

contains

!-----------------------------------------------------------------------
!! Subroutine: solve_runge_kutta_4
!-----------------------------------------------------------------------
!! By
!!
!!----------------------------------------------------------------------
!! Input:
!!
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine solve_runge_kutta_4()
    implicit none
    ! ... 
    ! You can use the class example as a starting
    ! point for your fourth order Runge Kutta
end subroutine solve_runge_kutta_4

    
end module ode_solver