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

public :: find_best_parameters, semi_empirical_mass, semi_empirical_error, find_stable_isotope, neutron_dripline
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
    allocate(c_parameters(1:n_parmaters))
    allocate(covariance(1:n_parmaters,1:n_parmaters))
    
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
!! By: Heng Yu
!!
!! The subroutine computes each elements in matrix alpha and vector beta.
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
    alpha_shape = shape(alpha)
    if (alpha_shape(1) /= alpha_shape(2)) then
        print *, 'Notice: the matrix shape of alpha is not a square'
    else if (alpha_shape(1) /= size(beta)) then
        print *, 'Notice: the size of beta does NOT match rows of alpha'
    endif

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
        do j=1, n_parmaters
            do k=1, n_parmaters
                alpha(j,k) = alpha(j,k) + (linear_terms(j)*linear_terms(k))/(uncertainties(i)**2)
            enddo
            beta(j) = beta(j) + (linear_terms(j)*exp_values(i))/(uncertainties(i)**2)
        enddo
    enddo
end subroutine construct_alpha_beta

!-----------------------------------------------------------------------
!! Subroutine: calculate_linear_termns
!-----------------------------------------------------------------------
!! by: Heng Yu
!!
!! The subroutine is to organize all of terms of parameters like c_volume, c_surface, etc.
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
!! By Heng Yu
!!
!! Calculating the paremeters of c_volume term
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
    r = Z+N
end function volume_term

!-----------------------------------------------------------------------
!! function: surface_term
!-----------------------------------------------------------------------
!! By Heng Yu
!!
!! Calculating the paremeters of c_surface term
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
    r =(Z+N)**(2/3)
end function surface_term

!-----------------------------------------------------------------------
!! function: asymmetry_term
!-----------------------------------------------------------------------
!! By Heng Yu
!!
!! Calculating the paremeters of c_asymmetry term
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
    r = (N-Z)**2/(N+Z)
end function asymmetry_term

!-----------------------------------------------------------------------
!! function: coulomb_term
!-----------------------------------------------------------------------
!! By Heng Yu
!!
!! Calculating the paremeters of c_coulomb term
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
    r = Z*(Z-1)/(Z+N)**(1/3)
end function coulomb_term

!-----------------------------------------------------------------------
!! function: pairing_term
!-----------------------------------------------------------------------
!! By: Heng Yu
!!
!! Calculating the paremeters of c_pairing term
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
    integer :: Dirac_Delta, reminder_Z, reminder_N

    reminder_Z = mod(Z,2)
    reminder_N = mod(N,2)

    if (reminder_Z == reminder_N) then
        if (reminder_N == 0) then
            Dirac_Delta = 1
        else
            Dirac_Delta = -1
        endif
    else
        Dirac_Delta = 0
    endif
    ! r = ...
    ! you might wanna define another function for the \delta(Z,N) factor in
    ! this term
    r = Dirac_Delta * (Z+N)**(-3/4)
end function pairing_term

!-----------------------------------------------------------------------
!! Subroutine: print_best_parameters
!-----------------------------------------------------------------------
!! By: Heng Yu
!!
!! It's to list the best parameters and uncertainty on the user.
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
    
    print *, 'Best fit values:              value                 uncertainty'
    print 1, ' Volume parameter:   ', c_parameters(1),      sqrt(covariance(1,1))
    print 1, ' Surface parameter:  ', c_parameters(2),      sqrt(covariance(2,2))
    print 1, ' Asymmetry parameter:', c_parameters(3),      sqrt(covariance(3,3))
    print 1, ' Coulomb parameter:  ', c_parameters(4),      sqrt(covariance(4,4))
    print 1, ' Pairing term:       ', c_parameters(5),      sqrt(covariance(5,5))

1 format(a,f15.8,e28.16)
end subroutine print_best_parameters



!-----------------------------------------------------------------------
!! function: semi_empirical_mass
!-----------------------------------------------------------------------
!! By: Heng Yu
!!
!! The function is to calculate the semi-empirical mass formula
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
    real(dp) :: linear_terms(1:size(c))
    integer :: i

    ! You can call the calculate_linear_termns subroutine and use its output
    call calculate_linear_termns(Z, N, linear_terms)
    ! to calculate the binding energy
    do i=1, size(c)
        r = r + c(i)*linear_terms(i)
    enddo
end function semi_empirical_mass

!-----------------------------------------------------------------------
!! function: semi_empirical_error
!-----------------------------------------------------------------------
!! By: Heng Yu
!!
!! The function is used to calculate the propagated uncertainty.
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
    integer :: shape_covariance(1:2), i, j
    real(dp), allocatable :: linear_terms(:)

    shape_covariance = shape(covariance)
    allocate(linear_terms(1:shape_covariance(1)))
    call calculate_linear_termns (Z, N, linear_terms)

    ! Do you need new functions or subroutine to calculate the derivatives of
    ! the semi-empirical mass formula with respect of each of the c
    ! coefficients or is it already coded?

    ! Follow the error formula in the README to calculate the theoretical
    ! error in the binding energy. The formula in the README gives the square
    ! of the error, don't forget to take the square root
    
    do i=1, shape_covariance(1)
        do j=1, shape_covariance(2)
            r = r + linear_terms(i)*linear_terms(j)*covariance(i,j)
        enddo
    enddo
    r = sqrt(r) 
end function semi_empirical_error

!--------------------------------------------------------------------------------
! Your advanced subroutines go here.
! Remember to document them!

! If you need any auxiliary functions (e.g. to look for the most bound nuclei
! given a value for Z or to calculate the separation energy) you can also
! define them here.

! Remember that the most bound nuclei is the one with the lowest (i.e. largest
! negative number) binding energy *per number of nucleons*.
subroutine find_stable_isotope(n_protons, n_neutrons, c_parameters, stable_isotope)
    implicit none
    real(dp), intent(in) :: c_parameters(:)
    integer, intent(in) :: n_protons(:), n_neutrons(:)
    integer, intent(out) :: stable_isotope(:)
    real :: choosen_result, new_result
    integer :: i, j, k,  gap_min, gap_max, N

    gap_min = 1
    gap_max = 1

    do i=1, 118     !Test from Z=1 to Z=118
        do k=gap_min, size(n_protons)   !Test the period of neutrons for the current number of protons Z.
            if (n_protons(k) == i) then !If such a index of Z still has same amount, max + 1.
                gap_max = gap_max + 1
            else
                exit
            endif
        enddo !When the loop ends, gap_max is the first index of next Z value, so the interval should be [gap_min , gap_max-1]


        choosen_result = semi_empirical_mass(c_parameters, n_protons(i), n_neutrons(gap_min))/(i + gap_min)
        do j=n_neutrons(gap_min), n_neutrons(gap_max-1) !Depends on the period of neutrons, find the smallest value of Binding Energy. 
            new_result = semi_empirical_mass(c_parameters, n_protons(i), n_neutrons(j))/(i + j)

            if (choosen_result >= new_result ) then
                choosen_result = new_result
                N = j
            endif
        enddo

        gap_min = gap_max !Reset the min_index to the max_index where is exactly the beginning of next Z amount.
        stable_isotope(i) = N !And set the most stable isotope to the current Z.
    enddo
    
end subroutine find_stable_isotope

subroutine neutron_dripline(n_protons, n_neutrons, c_parameters, S_n)
    implicit none
    real(dp), intent(in) :: c_parameters(:)
    integer, intent(in) :: n_protons(:), n_neutrons(:)
    integer, intent(out) :: S_n(:)
    real :: first_term, second_term, subtraction
    integer :: i, j, k, gap_min, gap_max, N

    gap_min = 1
    gap_max = 1

    do i=1, 118     !Test from Z=1 to Z=118
        do k=gap_min, size(n_protons)   !Test the period of neutrons for the current number of protons Z.
            if (n_protons(k) == i) then !If such a index of Z still has same amount, max + 1.
                gap_max = gap_max + 1
            else
                exit
            endif
        enddo !When the loop ends, gap_max is the first index of next Z value, so the interval should be [gap_min , gap_max-1]



        do j=n_neutrons(gap_min+1), n_neutrons(gap_max-1) !Depends on the period of neutrons, find the smallest value of Binding Energy. 
            first_term = semi_empirical_mass(c_parameters, n_protons(i),n_neutrons(j-1))
            second_term = semi_empirical_mass(c_parameters, n_protons(i), n_neutrons(j))
            subtraction = first_term - second_term


            if (subtraction > 0) then
                N = i + j
            endif

        enddo

        gap_min = gap_max !Reset the min_index to the max_index where is exactly the beginning of next Z amount.
        S_n(i) = N !And set the most stable isotope to the current Z.
    enddo
    
end subroutine neutron_dripline

end module nuclear_model