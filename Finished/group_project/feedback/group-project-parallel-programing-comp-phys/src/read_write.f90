!-----------------------------------------------------------------------
!Module: read_write
!-----------------------------------------------------------------------
!! By: 
!!
!! Explain the subroutines and functions included in the module
!!----------------------------------------------------------------------
!! Included subroutines:
!!
!! 
!!----------------------------------------------------------------------
!! Included functions:
!!
!! 
!-----------------------------------------------------------------------
module read_write
use types
!use potential, only : 
implicit none

private
public :: read_input, write_potential, print_wall_clock_time

contains

!-----------------------------------------------------------------------
!! Subroutine: read_input
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine read_input(length, rho_zero, center, width, n_max)
    implicit none
    real(dp), intent(out) :: length(1:2)
    real(dp), intent(out) :: rho_zero
    real(dp), intent(out) :: center(1:2), width(1:2)
    integer, intent(out) :: n_max
    
    integer :: unit1, ios

    namelist /box/ length
    namelist /charge_distribution/ rho_zero, center, width
    namelist /sampling/ n_max


end subroutine read_input

!-----------------------------------------------------------------------
!! Subroutine: write_potential
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!
!!----------------------------------------------------------------------
!! Input:
!!
!-----------------------------------------------------------------------
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine write_potential()
    implicit none

end subroutine write_potential

!-----------------------------------------------------------------------
!! Subroutine: print_wall_clock_time
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!
!!----------------------------------------------------------------------
!! Input:
!!
!-----------------------------------------------------------------------
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine print_wall_clock_time(count_1, count_2, count_rate)
    implicit none
    integer, intent(in) :: count_1, count_2, count_rate
    
end subroutine print_wall_clock_time

end module read_write
