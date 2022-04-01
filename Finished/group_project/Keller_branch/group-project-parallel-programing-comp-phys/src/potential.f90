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
use quadrature, only : booles_quadrature
implicit none

private
public :: calculate_coefficients, phi_potential


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
subroutine calculate_coefficients(length, rho_zero, center, width, n_max, n_samples, c_fourier)
    implicit none
    real(dp), intent(in) :: length(1:2), rho_zero, center(1:2), width(1:2)
    integer, intent(in) :: n_max, n_samples
    real(dp), allocatable, intent(out) :: c_fourier(:,:)
    integer :: m, n
    real(dp) :: l_x, l_y, r_x, r_y, rho_mn

    allocate(c_fourier(1:n_max, 1:n_max))
    l_x = length(1)
    l_y = length(2)

    r_x = width(1)
    r_y = width(2)

    !rho = (rho_zero/(pi*r_x*r_y))*exp((-(x-center(1))**2/r_x**2) &
    !       - ((y-center(2))**2/r_y**2))

    do m = 1, n_max
        do n = 1, n_max
            ! rho_mn = some numerical 2D integral
            ! c_fourier(m, n) = rho_mn/((m*pi/l_x)**2 + (n*pi/l_y)**2)
            rho_mn = calculate_rho_nm(length, rho_zero, center, width, n_samples, m, n)
            c_fourier(m, n) = rho_mn/((m*pi/l_x)**2 + (n*pi/l_y)**2)
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
            r = r + c_fourier(m,n)*(2/(length(1)*length(2)))*cos((m*pi*x)/length(1))*cos((n*pi*y)/length(2))
        enddo
    enddo

end function phi_potential

!-----------------------------------------------------------------------
!! Function: calculate_rho_nm
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
real(dp) function calculate_rho_nm(length, rho_zero, center, width, n_samples, m, n) result(integral)
    implicit none
    real(dp), intent(in) :: length(:), rho_zero, center(1:2), width(1:2)
    integer, intent(in) :: n_samples, m, n

    real(dp) :: delta_x, delta_y
    real(dp), allocatable :: f_x(:), g_xy(:)
    integer :: i_x, i_y
    real(dp) :: x, y, z

    delta_x = length(1)/(n_samples-1)
    delta_y = length(2)/(n_samples-1)

    allocate( f_x(1:n_samples))
    allocate(g_xy(1:n_samples))

    do i_x = 1, n_samples
        x = (i_x - 1) * delta_x

        do i_y = 1, n_samples
            y = (i_y - 1) * delta_y
            g_xy(i_y) = function_of_integral(length, rho_zero, center, width, x, y, m, n)
        enddo

        f_x(i_x) = booles_quadrature(g_xy, delta_y)
    enddo

    integral = booles_quadrature(f_x, delta_x) * 2.0/sqrt(length(1)*length(2))
    
end function calculate_rho_nm

!-----------------------------------------------------------------------
!! Function: function_of_integral
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
real(dp) function function_of_integral(length, rho_zero, center, width, x, y, m, n) result(k)
    implicit none
    real(dp), intent(in) :: length(:), rho_zero, center(1:2), width(1:2), x, y
    real(dp) :: rho_xy, second_part, r_x, r_y
    integer :: m, n

    r_x = width(1)
    r_y = width(2)

    rho_xy = (rho_zero/(pi*r_x*r_y))*exp((-(x-center(1))**2/r_x**2) &
           - ((y-center(2))**2/r_y**2))

    !first_part = rho_zero/(pi*width(1)*width(2)) * exp(-((x-center(1))/width(1))**2 - ((y-center(2))/width(2))**2)
    second_part = cos(m*pi*x/length(1)) * cos(n*pi*y/length(2))

    k = rho_xy * second_part
end function function_of_integral


end module potential