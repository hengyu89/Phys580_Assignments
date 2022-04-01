!-----------------------------------------------------------------------
!Module: neutron_flux
!-----------------------------------------------------------------------
!! By:
!!
!! Describe the purpose of the subroutines and functions in the module
!!----------------------------------------------------------------------
!! Included subroutines:
!!
!! box_flux_monte_carlo
!! hollow_box_flux_mc
!!----------------------------------------------------------------------
!! Included functions:
!!
!! box_flux_booles
!! sphere_flux_booles
!! total_flux_booles
!! sphere_flux_kernel
!! flux_kernel
!! flux_kernel_vector
!! hollow_box_flux_kernel
!! large_x0_flux
!-----------------------------------------------------------------------
module neutron_flux
use types
use quadrature, only : booles_quadrature, monte_carlo_quad

implicit none

private
public :: box_flux_booles, large_x0_flux, box_flux_monte_carlo!, hollow_box_flux_mc, total_flux_booles

contains

! Let's do the Boole's integration first

!-----------------------------------------------------------------------
!! Function: box_flux_booles
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the function does
!! 
!!----------------------------------------------------------------------
!! Input:
!!
!! depth        real        Depth of the rectangular nuclear reactor
!! width        real        Width of the rectangular nuclear reactor
!! height       real        Height of the rectangular nuclear reactor
!! x_zero       real        x coordinate of the detector's position
!! y_zero       real        y coordinate of the detector's position
!! n_grid       integer     number of grid points (in each dimension) used the the quadrature
!!----------------------------------------------------------------------
!! Output:
!!
!! flux         real        Result of the 3 dimensional integral
!-----------------------------------------------------------------------
real(dp) function box_flux_booles(depth, width, height, x_zero, y_zero, n_grid) result(flux)
    implicit none
    real(dp), intent(in) :: depth, width, height, x_zero, y_zero
    integer, intent(in) :: n_grid
    
    real(dp) :: delta_x, delta_y, delta_z
    real(dp), allocatable :: f_x(:), g_xy(:), h_xyz(:)
    integer :: n_bins, i_x, i_y, i_z
    real(dp) :: x, y, z

    ! I'll give you some help here. 

    ! First we need to determine the distance between
    ! the lattice points at which the function to integrate
    ! will be evaluated $\Delta x$.

    ! Hopefully the little diagram bellow will help you
    ! figure it out

    ! bins:              1   2   3   4   5   6   7   8
    ! x interval:      |---|---|---|---|---|---|---|---|
    ! grid points:     1   2   3   4   5   6   7   8   9 
    
    ! interval length: |-------------------------------|
    !                  0                               depth
    ! delta x length:  |---|
    !                  0   delta_x

    ! n_bins = ...

    ! delta_x = ...
    ! delta_y = ...
    ! delta_z = ...


    ! Now we need to allocate memory for the arrays that will contain
    ! the evaluated function to integrate
    allocate(  f_x(1:n_grid))
    allocate( g_xy(1:n_grid))
    allocate(h_xyz(1:n_grid))

    ! Now we need to implement the do loop in the README file

    do i_x = 1, n_grid
        ! how do you determine the value of x based on the lattice point i_x?
        ! The diagram above might help you
        ! x = ...
        do i_y = 1, n_grid
            ! how do you determine the value of y based on the lattice point i_y?
            ! y = ...
            do i_z = 1, n_grid
                ! z = ...
                ! Now you can fill the h_xyz array with an evaluation of the function
                ! to integrate. To make things cleaner will define a function 
                ! below that returns the value we want
                h_xyz(i_z) = flux_kernel(x, y, z, x_zero, y_zero)
            enddo
            ! Based on the pseudo code on the README file, how would you fill
            ! the g_xy array?
            ! The function to do the integral is defined in the quadrature module
            ! g_xy(i_y) = ...
        enddo
        ! And what about f_x?
        ! f_x(i_x) = ...
    enddo
    ! And finally, what's the final integral ?
    ! flux = ...
end function box_flux_booles

!-----------------------------------------------------------------------
!! Function: flux_kernel
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what the function does here
!!
!! 
!!----------------------------------------------------------------------
!! Input:
!!
!! x            real        x coordinate of the small integration volume
!! y            real        y coordinate of the small integration volume
!! y            real        z coordinate of the small integration volume
!! x0           real        x coordinate of the detector's position
!! y0           real        y coordinate of the detector's position
!!----------------------------------------------------------------------
!! Output:
!!
!! k            real        kernel to be integrated
!-----------------------------------------------------------------------
real(dp) function flux_kernel(x, y, z, x0, y0) result(k)
    implicit none
    real(dp), intent(in) :: x, y, z, x0, y0

    ! The function to be integrated goes here.
    ! The value of pi = 3.141592... is already available to you 
    ! because it's defined in the types module (take a look!)
    
    ! k = ...
end function flux_kernel

!-----------------------------------------------------------------------
!! Function: large_x0_flux
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! d            real        Depth of the rectangular nuclear reactor
!! w            real        Width of the rectangular nuclear reactor
!! h            real        Height of the rectangular nuclear reactor
!! x0           real        x coordinate of the detector's position
!! y0           real        y coordinate of the detector's position
!!----------------------------------------------------------------------
!! Output:
!!
!! flux         real        Result of the 3 dimensional integral
!!----------------------------------------------------------------------
real(dp) function large_x0_flux(d, w, h, x0, y0) result(flux)
    implicit none
    real(dp), intent(in) :: d, w, h, x0, y0
    ! Look in the README for guidance on what this function should calculate
    !flux = ....
end function large_x0_flux

!-----------------------------------------------------------------------
!! Subroutine: box_flux_monte_carlo
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!! 
!!----------------------------------------------------------------------
!! Input:
!!
!! depth        real        Depth of the rectangular nuclear reactor
!! width        real        Width of the rectangular nuclear reactor
!! height       real        Height of the rectangular nuclear reactor
!! x_zero       real        x coordinate of the detector's position
!! y_zero       real        y coordinate of the detector's position
!! n_samples    integer     number of sample points in the Monte Carlo integration
!!----------------------------------------------------------------------
!! Output:
!!
!! flux         real        Result of the Monte Carlo integral
!! sigma_f      real        Estimate of the uncertainty in the Monte Carlo integral
!-----------------------------------------------------------------------
subroutine box_flux_monte_carlo(depth, width, height, x_zero, y_zero, n_samples, flux, sigma_f)
    implicit none
    real(dp), intent(in) :: depth, width, height, x_zero, y_zero
    integer, intent(in) :: n_samples
    real(dp), intent(out) :: flux, sigma_f
    
    real(dp) :: a(1:3), b(1:3), data(1:2)

    ! This I'll give you for free!

    ! a is the lower integration limit in the x, y, z coordinates. 
    ! since the origin was placed at the corner of the nuclear reactor the
    ! lower limit is zero in all coordinates
    a = 0._dp

    ! b is the upper integration limit in the x, y, z coordinates.
    b(1) = depth
    b(2) = width
    b(3) = height

    ! This is the 'work array' we saw in class and contains parameters
    ! (other than the sample point) needed to evaluate the function to
    ! integrate
    data(1) = x_zero
    data(2) = y_zero

    ! Notice that we're sending a function called flux_kernel_vector to
    ! the Monte Carlo subroutine. We need to define that function below. 
    call monte_carlo_quad(flux_kernel_vector, a, b, data, n_samples, flux, sigma_f)
end subroutine box_flux_monte_carlo

!-----------------------------------------------------------------------
!! Function: flux_kernel_vector
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what the function does
!! 
!!----------------------------------------------------------------------
!! Input:
!!
!! x_vector     real        array containing the x, y, z, coordinates of the integration volume
!! data         real        work array containing the x, y coordinates of the detector's position
!!----------------------------------------------------------------------
!! Output:
!!
!! k            real        kernel to be integrated
!-----------------------------------------------------------------------
! Because of the interface defined in the quadrature module the 
! Monte Carlo subroutine expects a kernel function that receives two
! arrays, the first one contains the sampling point, the second one
! contains the parameters needed to calculate the kernel. 
real(dp) function flux_kernel_vector(x_vector, data) result(k)
    implicit none
    real(dp), intent(in) :: x_vector(:), data(:)

    real(dp) :: x, y, z, x0, y0

    !x = ...
    !y = ...
    !z = ...
    !x0 = ...
    !y0 = ...

    ! We're going to use the function we already defined for the 
    ! Boole's integration.
    !k = flux_kernel(...)
end function flux_kernel_vector

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!! ADVANCED PART STARTS HERE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! As explained in the README, for Boole's method we need to calculate
! the flux of the solid box and subtract the flux from a solid sphere.
! Let's start defining the function that calculates the flux of a 
! solid sphere

!-----------------------------------------------------------------------
!! Function: sphere_flux_booles
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the function does
!! 
!!----------------------------------------------------------------------
!! Input:
!!
!! distance     real        Distance from the center of the reactor to the detector
!! radius       real        Radius of the spherical reactor
!! n_grid       integer     number of grid points (in each dimension) used the the quadrature
!!----------------------------------------------------------------------
!! Output:
!!
!! flux         real        Result of the 3 dimensional integral
!-----------------------------------------------------------------------
real(dp) function sphere_flux_booles(distance, radius, n_grid) result(flux)
    implicit none
    real(dp), intent(in) :: distance, radius
    integer, intent(in) :: n_grid

    real(dp) :: delta_r, delta_theta
    real(dp), allocatable :: f_r(:), g_rtheta(:)
    integer :: n_bins, i_r, i_theta
    real(dp) :: r, theta

    ! Base the rest of the function on the one for the solid box.
    ! Here we're integrating only two variables (r and theta).
    ! r is integrated from 0 to radius while theta is integrated
    ! from 0 to pi 

    ! distance is the distance from the center of the sphere 
    ! to the position of the detector (capital R in the README).
    ! It will be given as a input to this function and passed
    ! to the sphere_flux_kernel function defined below

end function sphere_flux_booles

!-----------------------------------------------------------------------
!! Function: sphere_flux_kernel
!-----------------------------------------------------------------------
!! By: 
!! Describe what the function does
!! 
!!----------------------------------------------------------------------
!! Input:
!!
!! r_prime      real        r coordinate of the small integration volume
!! theta        real        theta coordinate of the small integration volume
!! big_r        integer     distance from the center of the sphere to the detector
!!----------------------------------------------------------------------
!! Output:
!!
!! k            real        kernel to be integrated
!-----------------------------------------------------------------------
real(dp) function sphere_flux_kernel(r_prime, theta, big_r) result(k)
    implicit none
    real(dp), intent(in) :: r_prime, theta, big_r
    
    ! The README says how to define this function
end function sphere_flux_kernel

!-----------------------------------------------------------------------
!! Function: total_flux_booles
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! depth        real        Depth of the rectangular nuclear reactor
!! width        real        Width of the rectangular nuclear reactor
!! height       real        Height of the rectangular nuclear reactor
!! radius       real        Radius of the hollow sphere
!! x_zero       real        x coordinate of the detector's position
!! y_zero       real        y coordinate of the detector's position
!! n_grid       integer     number of grid points (in each dimension) used the the quadrature
!!----------------------------------------------------------------------
!! Output:
!!
!! flux         real        Result of the 3 dimensional integral
!-----------------------------------------------------------------------
real(dp) function total_flux_booles(depth, width, height, radius, x_zero, y_zero, n_grid) result(flux)
    implicit none
    real(dp), intent(in) :: depth, width, height, radius, x_zero, y_zero
    integer, intent(in) :: n_grid

    real(dp) distance, box_flux, sphere_flux

    ! Now that we have a function to calculate the flux of the solid box and
    ! another one for the solid sphere we just need to use both functions 
    ! and calculate the difference.

    ! distance is the distance between the position of the detector (x_zero, y_zero)
    ! and the center of the sphere (which is also the center of the box)
    ! distance = ...

    ! ...

end function total_flux_booles

! As explained in the README the Monte Carlo approach is simpler.
! We just need to define a new kernel function that is zero if the 
! sampling point is inside the sphere and the original kernel if
! the sampling point is outside of the sphere.

! Again, this new kernel will take to arrays, one with the coordinates
! of the sampling point and one with all the other needed parameters
! this time it's more than just the position of the detector.

!-----------------------------------------------------------------------
!! Function: hollow_box_flux_kernel
!-----------------------------------------------------------------------
!! By:
!!
!! Explain what the function does
!! 
!!----------------------------------------------------------------------
!! Input:
!!
!! x_vector     real        array containing the x, y, z, coordinates of the integration volume
!! data         real        work array containing the sphere's radius and x, y coordinates of the detector's position
!!----------------------------------------------------------------------
!! Output:
!!
!! k            real        kernel to be integrated
!-----------------------------------------------------------------------
real(dp) function hollow_box_flux_kernel(x_vector, data) result(k)
    implicit none
    real(dp), intent(in) :: x_vector(:), data(:)

    real(dp) :: x, y, z, x0, y0!, .... what other parameters do you need? 
    real(dp) :: distance_to_center

    ! x = ...
    ! y = ...
    ! z = ...

    ! x0 = ...
    ! y0 = ...

    ! We need to determine whether or not the sampling point is inside the 
    ! sphere. For that you can calculate the distance from the sampling point
    ! (THIS IS NOT THE POSITION OF THE DETECTOR) and the center of the sphere 
    ! and compare it with the sphere's radius
    ! Remember that the origin was located at one corner of the box.

    ! distance_to_center = ....

    ! Now you just need an if statement along the lines of

    ! if inside the sphere then
    !     k = 0._dp
    ! else
    !     k = flux_kernel(...)
    ! end if

end function hollow_box_flux_kernel


!-----------------------------------------------------------------------
!! Subroutine: hollow_box_flux_mc
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what the subroutine does
!! 
!!----------------------------------------------------------------------
!! Input:
!!
!! depth        real        Depth of the rectangular nuclear reactor
!! width        real        Width of the rectangular nuclear reactor
!! height       real        Height of the rectangular nuclear reactor
!! radius       real        Radius of the hollow sphere
!! x_zero       real        x coordinate of the detector's position
!! y_zero       real        y coordinate of the detector's position
!! n_samples    integer     number of sample points in the Monte Carlo integration
!!----------------------------------------------------------------------
!! Output:
!!
!! flux         real        Result of the Monte Carlo integral
!! sigma_f      real        Estimate of the uncertainty in the Monte Carlo integral
!-----------------------------------------------------------------------
subroutine hollow_box_flux_mc(depth, width, height, radius, x_zero, y_zero, n_samples, flux, sigma_f)
    implicit none
    real(dp), intent(in) :: depth, width, height, radius, x_zero, y_zero
    integer, intent(in) :: n_samples
    real(dp), intent(out) ::  flux, sigma_f

    real(dp) :: a(1:3), b(1:3), data(1:6)

    ! Base the rest of the function on the one from the basic part of the project
    ! Remember that the 'work array' data now contains more information 
    ! 

    ! a = ...
    ! b(1) = ...
    ! ....

    ! data(1) = ...
    ! ...
    ! be sure to give the information in the same order than 
    ! the hollow_box_flux_kernel will take it
    
    ! call monte_carlo_quad(...)
end subroutine hollow_box_flux_mc

end module neutron_flux