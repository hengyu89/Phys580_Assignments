!-----------------------------------------------------------------------
!Module: read_write
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
module read_write

use types
use nuclear_model, only : semi_empirical_mass, semi_empirical_error, find_stable_isotope, neutron_dripline

implicit none

private
public :: read_exp_data, write_predictions, write_advance

contains

!-----------------------------------------------------------------------
!! Subroutine: read_exp_data
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what the subroutine does
!!----------------------------------------------------------------------
!! Output:
!!
!! n_protons        integer     Array containing the number of protons in each data point
!! n_neutrons       integer     Array containing the number of neutrons in each data point
!! exp_values       real        Array containing the binding energy in each data point
!! uncertainties    real        Array containing the statistical uncertainty in each data point
!-----------------------------------------------------------------------
subroutine read_exp_data(n_protons, n_neutrons, exp_values, uncertainties)
    implicit none
    integer, intent(out), allocatable :: n_protons(:), n_neutrons(:)
    real(dp), intent(out), allocatable :: exp_values(:), uncertainties(:)

    character(len=128) :: filename
    logical :: file_exists
    integer :: file_unit, n_data, junk, i
    real(dp) :: junk_r
    character(len=2) :: syneol


    ! use the print statement to display a message explaining what the program
    ! does

    print *, 'This program will take the values from user then compute the binding energy.'

    print *, 'please provide the file name with the experimental data'
    read(*, '(a)') filename

    ! when trying to allocate an array that was passed as an argument, it's
    ! always good idea to deallocate them if for whatever reason they're
    ! already allocated
    
    if(allocated(n_protons)) deallocate(n_protons)
    ! if(allocated(n_neutrons)) ...
    ! if ...
    ! ...
    if(allocated(n_neutrons)) deallocate(n_neutrons)
    if(allocated(exp_values)) deallocate(exp_values)
    if(allocated(uncertainties)) deallocate(uncertainties)

    ! when trying to open a file provided by the user it's good practice to
    ! check if the file exists in the current directory
    inquire(file=trim(filename), exist=file_exists)

    if (file_exists) then
        ! Open the file and read the data. (don't forget to close the file)
        ! You'll need to:
        !  * read the number of data from the first line in the file
        !  * skip the two following lines (there's no data in those!)
        !  * allocate the arrays with the appropriate size
        !  * read the data and store it in the arrays you just allocated
        open(newunit = file_unit, file = filename)
        read(file_unit,*) n_data
        read(file_unit,*)
        read(file_unit,*)
        allocate(n_protons(1:n_data))
        allocate(n_neutrons(1:n_data))
        allocate(exp_values(1:n_data))
        allocate(uncertainties(1:n_data))

        do i=1, n_data
            read(file_unit,*) junk, syneol, junk, n_neutrons(i), n_protons(i), exp_values(i), junk_r, uncertainties(i)
        enddo 
        close(file_unit)

        ! There's additional kind of data in the file, make sure you only read
        ! the data you need. You need the columns labeled as N, Z, E and dE
    else
        ! Give a message saying that the file can not be found and stop the
        ! program
        print *, 'Unforturanly, the file can NOT be found in this directory.'
    endif
end subroutine read_exp_data

!-----------------------------------------------------------------------
!! Subroutine: write_predictions
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!----------------------------------------------------------------------
!! Input:
!!
!! exp_values       real        Array containing the binding energy in each data point
!! uncertainties    real        Array containing the statistical uncertainty in each data point
!! c_parameters     real        Array containing the parameters of the semi-empirical mass formula
!! covariance       real        Array containing the elements of the covariance matrix
!! n_protons        integer     Array containing the number of protons in each data point
!! n_neutrons       integer     Array containing the number of neutrons in each data point
!-----------------------------------------------------------------------
subroutine write_predictions(exp_values, uncertainties, c_parameters, covariance, n_protons, n_neutrons)
    implicit none
    real(dp), intent(in) :: c_parameters(:), covariance(:,:), exp_values(:), uncertainties(:)
    integer, intent(in) :: n_protons(:), n_neutrons(:)
    character(len=*), parameter :: file_name = 'results.dat'
    integer :: unit, i
    real(dp) :: T_values, T_uncertainties

    ! Using the semi_empirical_mass and semi_empirical_error functions defined
    ! in the nuclear_model module, write a subroutine that writes down in a
    ! file the six following columns number of protons, number of neutrons,
    ! experimental binding energy, experimental error, theoretical binding
    ! energy and theoretical error

    ! Don't forget to put a header in the file.
    
    open (newunit=unit, file=file_name)
    write(unit,'(6a28)') 'Z', 'N', 'exp_values', 'uncertainties', 'c_parameters', 'error'

    do i=1, size(n_protons) !until the largest value of Z, here the last term of n_protons is 118.
        T_values = semi_empirical_mass(c_parameters, n_protons(i), n_neutrons(i))
        T_uncertainties = semi_empirical_error(covariance, n_protons(i), n_neutrons(i))
        write(unit,'(2i28,4e28.16)') n_protons(i), n_neutrons(i), exp_values(i), uncertainties(i), T_values, T_uncertainties
    enddo

    close(unit)

    print *, 'Finished.'
    print *, 'theoretical binding energies were written in ', file_name
end subroutine write_predictions

!--------------------------------------------------------------------------------
! Your advanced subroutine goes here.
! Remember to document your new subroutine
! In order to work with the jupyter notebook. Write down the results in a file named 
! 'results_advanced.dat'.
subroutine write_advance(n_protons, n_neutrons, c_parameters)
    implicit none
    real(dp), intent(in) :: c_parameters(:)
    integer, intent(in) :: n_protons(:), n_neutrons(:)
    character(len=*), parameter :: file_name = 'results_advanced.dat'
    integer :: unit, i, Number_Z
    integer, allocatable :: stable_isotope(:), S_n(:)

    Number_Z = n_protons(size(n_protons))
    allocate(stable_isotope(1:n_protons(size(n_protons))))
    allocate(S_n(1:n_protons(size(n_protons))))



    call find_stable_isotope(n_protons, n_neutrons, c_parameters, stable_isotope)
    call neutron_dripline(n_protons, n_neutrons, c_parameters, S_n)

! The file should have 3 columns. The number of protons, the position (value
! of N) for the stable isotopes, and the position (value of N) for the neutron
! drip-line
    open (newunit=unit, file=file_name)
    write(unit,'(3a28)') 'Z', 'stable isotope position', 'neutron drip-line position'

    do i=1, n_protons(size(n_protons))
        write(unit,'(3i28)') i, stable_isotope(i), S_n(i)
    enddo

    close(unit)
    
end subroutine write_advance

!
! Don't forget to put a header in the file. ???
    
end module read_write