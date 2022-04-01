!-----------------------------------------------------------------------
!Module: nuclear_model
!-----------------------------------------------------------------------
!! By:
!!
!! Describe the purpose of the subroutines and functions included in the
!! module
!!----------------------------------------------------------------------
!! Included subroutines:
!!
!! ...
!!----------------------------------------------------------------------
!! Included functions:
!!
!! ...
!!----------------------------------------------------------------------
module nuclear_model
use types
use linear_algebra, only : solve_linear_system
implicit none

private

public :: find_best_parameters, semi_empirical_mass, semi_empirical_error!, ... your subroutine for the advanced part will go here
contains


!-----------------------------------------------------------------------
!! Subroutine: find_best_parameters
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!----------------------------------------------------------------------
!! Input:
!!
!! n_protons        integer     Array containing the number of protons in each data point
!! n_neutrons       integer     Array containing the number of neutrons in each data point
!! exp_values       real        Array containing the binding energy in each data point
!! uncertainties    real        Array containing the statistical uncertainty in each data point
!-----------------------------------------------------------------------
!! Output:
!!
!! c_parameters     real        Array containing the semi-empirical mass formula parameters
!! covariance       real        Array containing the covariance matrix of the parameters
!-----------------------------------------------------------------------
subroutine find_best_parameters(n_protons, n_neutrons, exp_values, uncertainties, c_parameters, covariance)
    implicit none
    integer, intent(in) :: n_protons(:), n_neutrons(:)
    real(dp), intent(in) :: exp_values(:), uncertainties(:)
    real(dp), intent(out), allocatable ::  c_parameters(:), covariance(:,:)

    ! If you do the extra credit you would change this to 6
    integer, parameter :: n_parmaters = 5

    real(dp) :: alpha(1:n_parmaters,1:n_parmaters), beta(1:n_parmaters)

    ! c_parameters and covariance were passed as arguments and need to be
    ! allocated. Deallocate them if they're allocated and then allocate them
    ! with the correct size
    
    call construct_alpha_beta(n_protons, n_neutrons, exp_values, uncertainties, alpha, beta)

    ! The subroutine below (defined in the linear_algebra module) should solve
    ! the matrix equation in the README and return the c_parameters and the
    ! inverse of alpha (the covariance matrix)
    call solve_linear_system(alpha,beta,c_parameters,covariance)
    ! Now just print the parameters (with it's uncertainties) to screen
    call print_best_parameters(c_parameters,covariance)
end subroutine find_best_parameters

!-----------------------------------------------------------------------
!! Subroutine: construct_alpha_beta
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!----------------------------------------------------------------------
!! Input:
!!
!! n_protons        integer     Array containing the number of protons in each data point
!! n_neutrons       integer     Array containing the number of neutrons in each data point
!! exp_values       real        Array containing the binding energy in each data point
!! uncertainties    real        Array containing the statistical uncertainty in each data point
!-----------------------------------------------------------------------
!! Output:
!!
!! alpha            real        Array containing the alpha matrix
!! beta             real        Array containing the beta vector
!-----------------------------------------------------------------------
subroutine construct_alpha_beta(n_protons, n_neutrons, exp_values, uncertainties, alpha, beta)
    implicit none
    integer, intent(in) :: n_protons(:), n_neutrons(:)
    real(dp), intent(in) :: exp_values(:), uncertainties(:)
    real(dp), intent(out) :: alpha(:,:), beta(:)

    integer :: n_data, n_parmaters, alpha_shape(1:2), i, j, k
    real(dp):: linear_terms(1:size(beta))

    ! Check if the alpha array is a square matrix
    ! Also check that beta has the same number of elements as alpha has rows (or columns)

    n_data = size(uncertainties)
    n_parmaters = alpha_shape(1)

    alpha = 0._dp
    beta = 0._dp
    do i=1,n_data
        ! The subroutine below should return the f_\alpha(Z_i,N_i) terms defined in
        ! the README file
        call calculate_linear_termns(n_protons(i), n_neutrons(i), linear_terms)
        ! how would you fill the alpha and beta arrays?
        !
        ! Don't hard code the fact that the model has five terms. Your routine
        ! should work independent of the number of terms in the linear model.
        ! That will allow you to easily implement the extra credit part of 
        ! the project
    enddo
end subroutine construct_alpha_beta

!-----------------------------------------------------------------------
!! Subroutine: calculate_linear_termns
!-----------------------------------------------------------------------
!! by:
!!
!! Describe what the subroutine does
!!----------------------------------------------------------------------
!! Input:
!!
!! Z                integer     number of protons in an isotope
!! N                integer     number of neutrons in an isotope
!-----------------------------------------------------------------------
!! Output:
!!
!! linear_terms        real        Array containing the linear terms in the semi-empirical mass formula
!-----------------------------------------------------------------------
subroutine calculate_linear_termns(Z, N, linear_terms)
    implicit none
    integer, intent(in) :: Z, N
    real(dp), intent(out) :: linear_terms(:)

    ! We could write down all the formulas for each term here. However, in
    ! order to keep the code readable and easy to understand  we'll  separate
    ! them into different functions
    linear_terms(1) = volume_term(Z,N)
    linear_terms(2) = surface_term(Z,N)
    linear_terms(3) = asymmetry_term(Z,N)
    linear_terms(4) = coulomb_term(Z,N)
    linear_terms(5) = pairing_term(Z,N)
    ! If you do the extra credit you would add your new term here
    ! linear_terms(6) = my_extra_term(Z,N)
end subroutine calculate_linear_termns

!-----------------------------------------------------------------------
!! function: volume_term
!-----------------------------------------------------------------------
!! By
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! Z            integer     number of protons in a nucleus
!! N            integer     number of neutrons in a nucleus
!-----------------------------------------------------------------------
!! Output:
!!
!! r            real        volume term
!-----------------------------------------------------------------------
real(dp) function volume_term(Z, N) result(r)
    implicit none
    integer, intent(in) :: Z, N
    ! r = ...
end function volume_term

!-----------------------------------------------------------------------
!! function: surface_term
!-----------------------------------------------------------------------
!! By
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! Z            integer     number of protons in a nucleus
!! N            integer     number of neutrons in a nucleus
!-----------------------------------------------------------------------
!! Output:
!!
!! r            real        surface term
!-----------------------------------------------------------------------
real(dp) function surface_term(Z, N) result(r)
    implicit none
    integer, intent(in) :: Z, N
    ! r = ...
end function surface_term

!-----------------------------------------------------------------------
!! function: asymmetry_term
!-----------------------------------------------------------------------
!! By
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! Z            integer     number of protons in a nucleus
!! N            integer     number of neutrons in a nucleus
!-----------------------------------------------------------------------
!! Output:
!!
!! r            real        asymmetry term
!-----------------------------------------------------------------------
real(dp) function asymmetry_term(Z, N) result(r)
    implicit none
    integer, intent(in) :: Z, N
    ! r = ...
end function asymmetry_term

!-----------------------------------------------------------------------
!! function: coulomb_term
!-----------------------------------------------------------------------
!! By
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! Z            integer     number of protons in a nucleus
!! N            integer     number of neutrons in a nucleus
!-----------------------------------------------------------------------
!! Output:
!!
!! r            real        coulomb term
!-----------------------------------------------------------------------
real(dp) function coulomb_term(Z, N) result(r)
    implicit none
    integer, intent(in) :: Z, N
    ! r = ...
end function coulomb_term

!-----------------------------------------------------------------------
!! function: pairing_term
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! Z            integer     number of protons in a nucleus
!! N            integer     number of neutrons in a nucleus
!-----------------------------------------------------------------------
!! Output:
!!
!! r            real        pairing term
!-----------------------------------------------------------------------
real(dp) function pairing_term(Z, N) result(r)
    implicit none
    integer, intent(in) :: Z, N
    ! r = ...
    ! you might wanna define another function for the \delta(Z,N) factor in
    ! this term
end function pairing_term

!-----------------------------------------------------------------------
!! Subroutine: print_best_parameters
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!----------------------------------------------------------------------
!! Input:
!!
!! c_parameters     real        Array containing the best fit parameters
!! covariance       real        Array containing covariance matrix
!-----------------------------------------------------------------------
subroutine print_best_parameters(c_parameters, covariance)
    implicit none
    real(dp), intent(in) :: c_parameters(:), covariance(:,:)

    ! This is an example of how to define and use formats

    ! How can you use the error formula in the README to calculate the error
    ! bar in each parameter?
    
    print *,
    print *, 'Best fit values:              value                 uncertainty'
    print 1, ' Volume parameter:   ', c_parameters(1)!, ...
    print 1, ' Surface parameter:  ', c_parameters(2)!, ...
    print 1, ' Asymmetry parameter:', c_parameters(3)!, ...
    print 1, ' Coulomb parameter:  ', c_parameters(4)!, ...
    print 1, ' Pairing term:       ', c_parameters(5)!, ...

1 format(a,f15.8,e28.16)
end subroutine print_best_parameters



!-----------------------------------------------------------------------
!! function: semi_empirical_mass
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! c    real        Array containing the parameters of the semi-empirical mass formula
!! Z    integer     number of protons in an isotope
!! N    integer     number of neutrons in an isotope
!-----------------------------------------------------------------------
!! Output:
!!
!! r    real        Binding energy
!-----------------------------------------------------------------------
real(dp) function semi_empirical_mass(c, Z, N) result(r)
    implicit none
    real(dp), intent(in) :: c(:)
    integer, intent(in) :: Z, N

    ! You can call the calculate_linear_termns subroutine and use its output
    ! to calculate the binding energy
end function semi_empirical_mass

!-----------------------------------------------------------------------
!! function: semi_empirical_error
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! covariance   real        2D array containing the parameters' covariance matrix
!! Z            integer     number of protons in an isotope
!! N            integer     number of neutrons in an isotope
!-----------------------------------------------------------------------
!! Output:
!!
!! r            real        statistical uncertainty in the binding energy
!-----------------------------------------------------------------------
real(dp) function semi_empirical_error(covariance, Z, N) result(r)
    implicit none
    real(dp), intent(in) :: covariance(:,:)
    integer, intent(in) :: Z, N

    ! Do you need new functions or subroutine to calculate the derivatives of
    ! the semi-empirical mass formula with respect of each of the c
    ! coefficients or is it already coded?

    ! Follow the error formula in the README to calculate the theoretical
    ! error in the binding energy. The formula in the README gives the square
    ! of the error, don't forget to take the square root
end function semi_empirical_error

!--------------------------------------------------------------------------------
! Your advanced subroutines go here.
! Remember to document them!

! If you need any auxiliary functions (e.g. to look for the most bound nuclei
! given a value for Z or to calculate the separation energy) you can also
! define them here.

! Remember that the most bound nuclei is the one with the lowest (i.e. largest
! negative number) binding energy *per number of nucleons*.

end module nuclear_model