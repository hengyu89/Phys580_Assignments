!-----------------------------------------------------------------------
!Module: mechanics
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
module mechanics
use types
implicit none
private
public :: planets_ode, calculate_energy

contains


!-----------------------------------------------------------------------
!! function: planets_ode
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
function planets_ode(r, t, work) result(f)
    implicit none
    real(dp), intent(in) :: r(:), t, work(:)
    real(dp), allocatable :: f(:)
    ! This is the function that will be sent to 
    ! solve_runge_kutta_4 as an argument.

    ! Your system of differential equation should 
    ! be defined here

    ! Make sure that the definition here matches
    ! your interface in the ode_solver module
end function planets_ode

!-----------------------------------------------------------------------
!! Subroutine: calculate_energy
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
subroutine calculate_energy()
    implicit none
    ! ...
end subroutine calculate_energy

   
end module mechanics