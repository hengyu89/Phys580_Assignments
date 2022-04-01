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
use nuclear_model, only : semi_empirical_mass, semi_empirical_error

implicit none

private
public :: read_exp_data, write_predictions

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
    integer :: file_unit


    ! use the print statement to display a message explaining what the program
    ! does

    print *, 'This program will ...'

    print *, 'please provide the file name with the experimental data'
    read(*, '(a)') filename

    ! when trying to allocate an array that was passed as an argument, it's
    ! always good idea to deallocate them if for whatever reason they're
    ! already allocated
    
    if(allocated(n_protons)) deallocate(n_protons)
    ! if(allocated(n_neutrons)) ...
    ! if ...
    ! ...

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

        ! There's additional kind of data in the file, make sure you only read
        ! the data you need. You need the columns labeled as N, Z, E and dE
    else
        ! Give a message saying that the file can not be found and stop the
        ! program
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
    real(dp), intent(in) :: exp_values(:), uncertainties(:), c_parameters(:), covariance(:,:)
    integer, intent(in) :: n_protons(:), n_neutrons(:)
    character(len=*), parameter :: file_name = 'results.dat'

    ! Using the semi_empirical_mass and semi_empirical_error functions defined
    ! in the nuclear_model module, write a subroutine that writes down in a
    ! file the six following columns number of protons, number of neutrons,
    ! experimental binding energy, experimental error, theoretical binding
    ! energy and theoretical error

    ! Don't forget to put a header in the file.

    print *,
    print *, 'theoretical binding energies were written in ', file_name
end subroutine write_predictions

!--------------------------------------------------------------------------------
! Your advanced subroutine goes here.
! Remember to document your new subroutine

! In order to work with the jupyter notebook. Write down the results in a file named 
! 'results_advanced.dat'.
!
! The file should have 3 columns. The number of protons, the position (value
! of N) for the stable isotopes, and the position (value of N) for the neutron
! drip-line
!
! Don't forget to put a header in the file.
    
end module read_write