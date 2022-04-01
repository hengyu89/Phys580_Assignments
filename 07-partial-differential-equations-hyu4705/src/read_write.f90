!-----------------------------------------------------------------------
!Module: read_write
!-----------------------------------------------------------------------
!! By
!!
!! Give an explanation of the subroutines and functions contained in the 
!! module
!!----------------------------------------------------------------------
!! Included subroutines:
!!
!!----------------------------------------------------------------------
!! Included functions:
!!
!-----------------------------------------------------------------------
module read_write
use types

implicit none

private
public :: read_input, write_time_evolution, write_expectation_values

contains

!-----------------------------------------------------------------------
!! Subroutine: read_input
!-----------------------------------------------------------------------
!! By:
!!
!! Give an explanation of what the subroutine does
!!----------------------------------------------------------------------
!! Input:
!!
!!----------------------------------------------------------------------
!! Output:
!!
!!----------------------------------------------------------------------
subroutine read_input(length, n_points, n_steps, delta_t, width, center, k_oscillator &
    , time_file, density_file)
    implicit none
    real(dp), intent(out) :: length, delta_t, width, center, k_oscillator
    integer, intent(out) :: n_points, n_steps
    character(len=*) :: time_file, density_file 

    namelist /integration/ length, n_points, n_steps, delta_t
    namelist /wave_function/ width, center
    namelist /oscillator/ k_oscillator
    namelist /output/ time_file, density_file

    length = 5._dp
    n_points = 100
    n_steps = 100
    delta_t = 0.05_dp
    width = 0.5_dp
    center = 0._dp
    k_oscillator = 0.0_dp
    time_file = 'time_results.dat'
    density_file = 'density_results.dat'

end subroutine read_input


!-----------------------------------------------------------------------
!! Subroutine: write_time_evolution
!-----------------------------------------------------------------------
!! By:
!!
!! Give an explanation of what the subroutine does
!!----------------------------------------------------------------------
!! Input:
!!
!!----------------------------------------------------------------------
!! Output:
!!
!!----------------------------------------------------------------------
subroutine write_time_evolution()
    implicit none

    !This subroutine should write to the density_file file the probability 
    !density at different times. The first LINE should contain the sample 
    !points along the x axis.

    !The successive lines should contain the probability density at  
    !different time steps.

    
end subroutine write_time_evolution

!-----------------------------------------------------------------------
!! Subroutine: write_expectation_values
!-----------------------------------------------------------------------
!! By:
!!
!! Give an explanation of what the subroutine does
!!----------------------------------------------------------------------
!! Input:
!!
!!----------------------------------------------------------------------
!! Output:
!!
!!----------------------------------------------------------------------
subroutine write_expectation_values()
    implicit none

    !This subroutine should write to the time_file file the expectation 
    !values as a function time. The first COLUMN should contain the times
    !at which the wave function was calculated

    !The successive columns should contain the expectation values 
    !(normalization, position, width) at the respective times.

    
end subroutine write_expectation_values

end module read_write
