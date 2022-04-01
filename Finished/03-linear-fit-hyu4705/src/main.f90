! Program: nuclear_energies
! By: 
!-----------------------------------------------------------------------------
! Describe what the program does
!-----------------------------------------------------------------------------
program nuclear_energies
use types
use read_write, only : read_exp_data, write_predictions, write_advance!, ... your advanced subroutines would go here
use nuclear_model, only : find_best_parameters!, ... your advanced subroutines would go here
implicit none

integer, allocatable :: n_protons(:), n_neutrons(:)
real(dp), allocatable :: exp_values(:), uncertainties(:), c_parameters(:), covariance(:,:)


call read_exp_data(n_protons, n_neutrons, exp_values, uncertainties)
call find_best_parameters(n_protons, n_neutrons, exp_values, uncertainties, c_parameters, covariance)
call write_predictions(exp_values, uncertainties, c_parameters, covariance, n_protons, n_neutrons)
print *,'the predictions have been written.'
call write_advance(n_protons, n_neutrons, c_parameters)

!------------------------------------------------------------
!ADVANCED PART OF THE PROJECT

! In the nuclear_model module write two new subroutines and call them here.
! One to find the position of the stable isotopes
! One to find the position of the neutron dripline
! 
! call ...
! call ...

! In the read_write module write a new subroutine to write the position of the
! stable isotopes and neutron dripline
!
! call ...

end program nuclear_energies