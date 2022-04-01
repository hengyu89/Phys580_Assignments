!-----------------------------------------------------------------------
!Module: quadrature
!-----------------------------------------------------------------------
!! By
!!
!! Describe the purpose of the functions and subroutines in this module
!!----------------------------------------------------------------------
!! Included subroutines:
!!
!! 
!! monte_carlo_quad
!!----------------------------------------------------------------------
!! Included functions:
!!
!! booles_quadrature
!! booles_rule
!-----------------------------------------------------------------------
module quadrature
use types

implicit none

private
public :: booles_quadrature, monte_carlo_quad

!-----------------------------------------------------------------------
!Interface: func
!-----------------------------------------------------------------------
!! This defines a new type of procedure in order to allow callbacks
!! in the Monte Carlo quadrature subroutine of an arbitrary function that is given
!! as input and declared as a procedure
!!
!! The arbitrary function receives two rank 1 arrays of arbitrary size.
!! The first array contains an n-dimensional vector representing the
!! point sampled by the Monte Carlo method. The second is a "work array"
!! that contains parameters  necessary to calculate the function to be
!! integrated.
!!----------------------------------------------------------------------
interface
    real(dp) function func(x, data)
        use types, only : dp
        implicit none
        real(dp), intent(in) :: x(:), data(:)
        ! This is the interface we saw in class that allows callbacks
    end function func
end interface

contains

!-----------------------------------------------------------------------
!! Function: booles_quadrature
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the function does
!! ----------------------------------------------------------------------
!! Input:
!!
!! fx           real        Array containing the evaluated function
!! delta_x      real        Distance between the evaluation points
!!----------------------------------------------------------------------
!! Output:
!!
!! s            real        Result of the Boole's quadrature
!-----------------------------------------------------------------------
real(dp) function booles_quadrature(fx, delta_x) result(s)
    implicit none
    real(dp), intent(in) :: fx(1:), delta_x

    integer :: fx_size, i

    fx_size = size(fx)

    ! As the diagram below shows, only certain number of grid points
    ! fit the scheme of Boole's quadrature. Implement a test 
    ! to make sure that the number of evaluated points in the fx array
    ! is the correct one

    ! |--interval 1---|--interval 2---|--interval 3---|
    ! 1   2   3   4   5   6   7   8   9   10  11  12  13
    ! |---|---|---|---|---|---|---|---|---|---|---|---|
    ! x0  x1  x2  x3  x4
    !                 x0  x1  x2  x3  x4
    !                                 x0  x1  x2  x3  x4


    ! if fx_size is not the correct one then
    !     print *, 'fx array size in booles_quadrature has to be ...'
    !     stop
    ! endif

    ! We could implement the full integration here, however to make a cleaner,
    ! easy to read (and debug or maintain) code we will define a smaller
    ! function that returns Boole's five point rule and pass slices (1:5), (5:9),
    ! (9:13), ... of fx to such function to then add all the results. 

    s = 0._dp

    ! do i = ...
    !     s = s + booles_rule(...)
    ! enddo
end function booles_quadrature

!-----------------------------------------------------------------------
!! Function: booles_rule
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the function does
!! ----------------------------------------------------------------------
!! Input:
!!
!! fx           real        Array containing the evaluated function
!! delta_x      real        Distance between the evaluation points
!!----------------------------------------------------------------------
!! Output:
!!
!! s            real        Result of the Boole's quadrature
!-----------------------------------------------------------------------
real(dp) function booles_rule(fx, delta_x) result(s)
    implicit none
    real(dp), intent(in) :: fx(1:), delta_x

    integer :: fx_size
    real(dp) :: fx0, fx1, fx2, fx3, fx4

    fx_size = size(fx)

    ! Let's make an additional test to make sure that the array
    ! received has 5 and only 5 points 

    ! if ... then
    !     ...
    ! endif
    
    ! fx0 = ...
    ! fx1 = ...
    ! ...
    
    ! s = ...
end function booles_rule

!-----------------------------------------------------------------------
!! Subroutine: monte_carlo_quad
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the function does
!! ----------------------------------------------------------------------
!! Input:
!!
!! f            procedure   function to be integrated
!! a            real        array containing the lower limits of the integral
!! b            real        array containing the upper limits of the integral
!! data         real        array containing parameters necessary to calculate the function f
!! n_samples    integer     number of sample points in the Monte Carlo integration
!!----------------------------------------------------------------------
!! Output:
!!
!! s            real        Result of the Monte Carlo integral
!! sigma_s      real        Estimate of the uncertainty in the Monte Carlo integral
!-----------------------------------------------------------------------
subroutine monte_carlo_quad(f, a, b, data, n_samples, s, sigma_s)
    implicit none
    procedure(func) :: f
    real(dp), intent(in) :: a(:), b(:), data(:)
    integer, intent(in) :: n_samples
    real(dp), intent(out) :: s, sigma_s

    integer :: i, vector_size
    real(dp), allocatable :: x_vector(:), fx(:)! ...you might need to declare other arrays here


    vector_size = size(a)

    ! We're defining a Monte Carlo routine that works for an arbitrary number of 
    ! dimensions in the integral (Remember, that's the advantage of Monte Carlo integration,
    ! it's very efficient for high dimensional integrals)

    ! Since a and b give the lower and upper limits they need to have the same size.
    ! Make a check to see if they do have the same size

    ! if a and b don't have the same size then
    !      print *, 'a and b arrays in monte_carlo_quad have to be the same size'
    !     stop       
    ! endif

    ! Here we allocate memory for the vector containing the sample points and 
    ! for a vector that contains the evaluated function
    allocate(x_vector(1:vector_size))
    allocate(fx(1:n_samples))

    do i=1,n_samples
        ! NEVER USE THE INTRINSIC FUNCTION RAND() to generate 'random' numbers
        ! It's NOT reliable when a large number of random numbers are necessary.
        ! The only reason it is still in some compilers is for backwards compatibility with old code. 

        ! Instead use the intrinsic function random_number() it's a more modern version in the
        ! current standard with a period of 2^{1024} - 1 (that's a HUGE number)

        ! However, caution should be used in parallel applications. Other pseudo random number
        ! generators are more appropriate for such cases. But that's beyond the scope of this class

        call random_number(x_vector) !generates an array with random numbers in the [0,1) interval
        x_vector = a + x_vector*(b-a) !rescaling to the integration volume [a,b)
        fx(i) = f(x_vector,data)
    enddo

    ! I'll leave the calculation of the integral and it's uncertainty to you
end subroutine monte_carlo_quad

end module quadrature