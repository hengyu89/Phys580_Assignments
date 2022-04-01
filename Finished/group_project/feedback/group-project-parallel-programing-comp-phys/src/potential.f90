!-----------------------------------------------------------------------
!! Module: potential
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
module potential
use types
!use quadrature, only : booles_quadrature
implicit none

private
public :: calculate_coefficients


contains

!-----------------------------------------------------------------------
!! Subroutine: calculate_coefficients
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
subroutine calculate_coefficients(length, rho_zero, center, width, n_max, c_fourier)
    implicit none
    real(dp), intent(in) :: length(1:2), rho_zero, center(1:2), width(1:2)
    integer, intent(in) :: n_max
    real(dp), allocatable, intent(out) :: c_fourier(:,:)
    integer :: m, n

    allocate(c_fourier(1:n_max, 1:n_max))

    do m = 1, n_max
        do n = 1, n_max
            ! rho_mn = some numerical 2D integral
            ! c_fourier(m, n) = rho_mn/((m*pi/l_x)**2 + (n*pi/l_y)**2)
        enddo
    enddo

end subroutine calculate_coefficients

!-----------------------------------------------------------------------
!! Function: phi_potential
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the function does
!!
!!----------------------------------------------------------------------
!! Input:
!!
!-----------------------------------------------------------------------
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
real(dp) function phi_potential(c_fourier, length, x, y) result(r)
    implicit none
    real(dp), intent(in) :: c_fourier(:,:), length(1:2), x, y
    integer :: m, n

    r = 0._dp

    do m=1,size(c_fourier, 1)
        do n=1,size(c_fourier, 2)
            !r = r + c_fourier(m,n)*... 
        enddo
    enddo

end function phi_potential


end module potential