!-----------------------------------------------------------------------
!Module: qm_solver
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! This Module is used to compute the state energies with both numerical and analytical, normalized probability 
!! densities separately in infinite well, Harmonic Oscillator and Woods-Saxon.
!!----------------------------------------------------------------------
!! Included subroutines:
!!
!! solve_infinite_well, sample_box, analytic_infinite_well, solve_harmonic_oscillator, &
!! analytic_harmonic_oscillator, solve_woods_saxon
!!----------------------------------------------------------------------
module qm_solver
use types
use hamiltonian, only : construct_tridiagonal, normalization, construct_harmonic_oscillator, construct_woods_saxon, h_bar, mass
use eigen_solver, only : solve_eigenproblem
implicit none

private
public solve_infinite_well, sample_box, analytic_infinite_well, solve_harmonic_oscillator, &
    analytic_harmonic_oscillator, solve_woods_saxon

contains

!-----------------------------------------------------------------------
!! Subroutine: sample_box
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! The subroutine returns the array of x with the given length and number of points.
!!
!!		length from -L to L |	.	.	.	|
!!		x vector 			x1	x2	x3	x4	x5
!!
!!		number of points is 5 here because dx = 2L/(N-1)
!!		and size of x = 5 which is N
!!----------------------------------------------------------------------
!! Input:
!!
!!	length		real		length of the box
!!	n_points 	integer		number of grid points the discretized wave function
!-----------------------------------------------------------------------
!! Output:
!!
!!	x_vector(:) 	real		Array of x separated by the number of points inside the box
!-----------------------------------------------------------------------
subroutine sample_box(length, n_points, x_vector)
    implicit none
    real(dp), intent(in) :: length
    integer, intent(in) :: n_points
    real(dp), intent(out), allocatable :: x_vector(:)
    real(dp) :: dx
    integer :: i

    allocate(x_vector(1:n_points))

    dx = (2*length)/(n_points-1)

    do i=1, size(x_vector)
        x_vector(i) = dx*(i-1) - length
    enddo

end subroutine sample_box

!-----------------------------------------------------------------------
!! Subroutine: solve_infinite_well
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! Returns the array of 3 lowest energies and another array of 3 
!! corresponding wave functions. 
!!----------------------------------------------------------------------
!! Input:
!!
!! n_points     	integer     	number of grid points the discretized wave function
!! length       	real(dp)        length of the box
!! x_vector(:) 		real(dp)		Array of x separated by the number of points inside the box
!-----------------------------------------------------------------------
!! Output:
!!
!! energies(:)		real(dp)		Array of 3 lowest value of energies
!! wave_functions 	real(dp)		Array of 3 corresponding wave function with energies
!-----------------------------------------------------------------------
subroutine solve_infinite_well(n_points, length, x_vector, wave_functions, energies)
    implicit none
    integer, intent(in) :: n_points
    real(dp), intent(in) :: length, x_vector(:)
    real(dp), intent(out) :: energies(:)
    real(dp), intent(out), allocatable :: wave_functions(:,:)
    real(dp), allocatable :: all_energies(:), all_wave_functions(:,:), d(:), e(:)
    real(dp) :: dx
    integer :: wave_functions_shape(1:2), i, j

    dx = 2 * length/(n_points-1)
    allocate(all_wave_functions(1:size(x_vector) , 1:size(x_vector)))
    allocate(all_energies(1:size(x_vector)))
    

    call construct_tridiagonal(x_vector, dx, d, e)                                                ! Returns d(:) and e(:)
    call solve_eigenproblem(d, e, all_energies, all_wave_functions)                               ! Returns all_energies(:), all_wave_functions(:,:)
    call normalization(length, x_vector, dx, all_wave_functions)                                  ! Returns normalized all_wave_functions(:,:)
    !! Now the subroutine has all_energies(:) and all_wave_functions(:,:), we need to find the 3 lowest value of energies and put into energies(:).
    !! Because it's ascending order thanks to the destv, so here just need to place the first three elements.
    allocate(wave_functions(1:size(x_vector) , 1:size(energies)))
    wave_functions_shape = shape(wave_functions)
    do i=1, size(energies)                          ! Just in case users want to expand the size of energies, so here uses size(energies) instead of 3. Same after that.
        energies(i) = all_energies(i)
        do j=1, wave_functions_shape(1)
            wave_functions(j,i) = all_wave_functions(j,i)
        enddo
    enddo


end subroutine solve_infinite_well

!-----------------------------------------------------------------------
!! Subroutine: analytic_infinite_well
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! The subroutine calculates the analytically three lowest energies for 
!! the particle in a box.
!!----------------------------------------------------------------------
!! Input:
!!
!! length               real(dp)        length of the box
!-----------------------------------------------------------------------
!! Output:
!!
!! analytic_energies    real(dp)        Array of 3 lowest value of analytical energies.
!-----------------------------------------------------------------------
subroutine analytic_infinite_well(length, analytic_energies)
    implicit none
    real(dp), intent(in) :: length
    real(dp), intent(out) :: analytic_energies(:)
    integer :: i


    do i=1, size(analytic_energies)
        analytic_energies(i) = (i*h_bar*pi)**2/(8*mass*length**2)
    enddo
end subroutine analytic_infinite_well

!-----------------------------------------------------------------------
!! Subroutine: solve_harmonic_oscillator
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! The subroutine will solve the Harmonic Oscillator problem.
!!----------------------------------------------------------------------
!! Input:
!!
!! n_points         integer         number of grid points the discretized wave function
!! length           real(dp)        length of the box
!! x_vector(:)      real(dp)        Array of x separated by the number of points inside the box
!-----------------------------------------------------------------------
!! Output:
!!
!! energies(:)      real(dp)        Array of 3 lowest value of energies
!! wave_functions   real(dp)        Array of 3 corresponding wave function with energies
!-----------------------------------------------------------------------
subroutine solve_harmonic_oscillator(n_points, length, x_vector, wave_functions, energies)
    implicit none
    integer, intent(in) :: n_points
    real(dp), intent(in) :: length, x_vector(:)
    real(dp), intent(out) ::energies(:)
    real(dp), intent(out) :: wave_functions(:,:)
    real(dp), allocatable :: d(:), e(:), potential_d(:), all_energies(:), all_wave_functions(:,:)
    real(dp) :: dx
    integer :: wave_functions_shape(1:2), i, j

    dx = 2 * length/(n_points-1)
    allocate(potential_d(1:size(x_vector)))
    allocate(all_wave_functions(1:size(x_vector) , 1:size(x_vector)))
    allocate(all_energies(1:size(x_vector)))

    call construct_tridiagonal(x_vector, dx, d, e)  
    call construct_harmonic_oscillator(length, x_vector, potential_d)
    do i=1, size(d)
        d(i) = d(i) + potential_d(i)
    enddo
    call solve_eigenproblem(d, e, all_energies, all_wave_functions)
    call normalization(length, x_vector, dx, all_wave_functions)

    wave_functions_shape = shape(wave_functions)
    do i=1, size(energies)                          ! Just in case users want to expand the size of energies, so here uses size(energies) instead of 3. Same after that.
        energies(i) = all_energies(i)
        do j=1, wave_functions_shape(1)
            wave_functions(j,i) = all_wave_functions(j,i)
        enddo
    enddo

end subroutine solve_harmonic_oscillator

!-----------------------------------------------------------------------
!! Subroutine: analytic_harmonic_oscillator
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! The subroutine calculates the analytically three lowest energies for 
!! the harmonic oscillator.
!!----------------------------------------------------------------------
!! Input:
!!
!-----------------------------------------------------------------------
!! Output:
!!
!! analytic_energies        real(dp)        vector that contains three lowest 
!!                                          energies for the harmonic oscillator.
!-----------------------------------------------------------------------
subroutine analytic_harmonic_oscillator(analytic_energies)
    implicit none
    real(dp), intent(out) :: analytic_energies(:)
    integer :: i


    do i=1, size(analytic_energies)
        analytic_energies(i) = (i-0.5)*h_bar**2/mass
    enddo

end subroutine analytic_harmonic_oscillator

!-----------------------------------------------------------------------
!! Subroutine: solve_woods_saxon
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! The subroutine solves the Woods-Saxon
!!----------------------------------------------------------------------
!! Input:
!!
!! n_points         integer         number of grid points the discretized wave function
!! length           real(dp)        length of the box
!! radius           real            radius of the Woods-Saxon potential
!! x_vector(:)      real(dp)        Array of x separated by the number of points inside the box
!-----------------------------------------------------------------------
!! Output:
!!
!! energies(:)      real(dp)        Array of 3 lowest value of energies
!! wave_functions   real(dp)        Array of 3 corresponding wave function with energies
!-----------------------------------------------------------------------
subroutine solve_woods_saxon(n_points, length, radius, x_vector, wave_functions, energies)
    implicit none
    integer, intent(in) :: n_points
    real(dp), intent(in) :: length, x_vector(:), radius
    real(dp), intent(out) ::energies(:)
    real(dp), intent(out) :: wave_functions(:,:)
    real(dp), allocatable :: d(:), e(:), woods_saxon_d(:), all_energies(:), all_wave_functions(:,:)
    real(dp) :: dx
    integer :: wave_functions_shape(1:2), i, j

    dx = 2 * length/(n_points-1)
    allocate(woods_saxon_d(1:size(x_vector)))
    allocate(all_wave_functions(1:size(x_vector) , 1:size(x_vector)))
    allocate(all_energies(1:size(x_vector)))

    call construct_tridiagonal(x_vector, dx, d, e)  
    call construct_woods_saxon(radius, x_vector, woods_saxon_d)
    do i=1, size(d)
        d(i) = d(i) + woods_saxon_d(i)
    enddo
    call solve_eigenproblem(d, e, all_energies, all_wave_functions)
    call normalization(length, x_vector, dx, all_wave_functions)

    wave_functions_shape = shape(wave_functions)
    do i=1, size(energies)                          ! Just in case users want to expand the size of energies, so here uses size(energies) instead of 3. Same after that.
        energies(i) = all_energies(i)
        do j=1, wave_functions_shape(1)
            wave_functions(j,i) = all_wave_functions(j,i)
        enddo
    enddo
end subroutine solve_woods_saxon

end module qm_solver