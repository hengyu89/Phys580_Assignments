!-----------------------------------------------------------------------
!Module: read_write
!-----------------------------------------------------------------------
!! By:
!!
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
public :: read_input, write_results

contains

!-----------------------------------------------------------------------
!! Subroutine: read_input
!-----------------------------------------------------------------------
!! By
!!
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine read_input(work_array, initial_condition, final_time, n_steps, output_file)
    implicit none
    real(dp), intent(out) :: work_array(1:3)
    real(dp), intent(out) :: initial_condition(1:8)
    real(dp), intent(out) :: final_time
    integer, intent(out) :: n_steps
    character(len=*) output_file
    real(dp) :: primary_mass, planet_mass_1, planet_mass_2
    real(dp) :: initial_pos_1(1:2), initial_pos_2(1:2)
    real(dp) :: initial_vel_1(1:2), initial_vel_2(1:2)



    namelist /masses/ primary_mass, planet_mass_1, planet_mass_2
    namelist /initial_conditions/ initial_pos_1, initial_pos_2, initial_vel_1, initial_vel_2
    namelist /solution_parameters/ final_time, n_steps
    namelist /output/ output_file


    ! Set default values
    ! primary_mass  = 
    ! planet_mass_1 = 
    ! planet_mass_2 = 
    ! initial_pos_1 = 
    ! initial_pos_2 = 
    ! initial_vel_1 = 
    ! initial_vel_2 = 
    ! final_time = 
    ! n_steps = 

    ! get namelist file name from command line

    ! read namelists

    ! You can follow what we did in class during the namelist example
    ! The code is in the class repository

    work_array = [primary_mass, planet_mass_1, planet_mass_2]
    initial_condition = [initial_pos_1, initial_pos_2, initial_vel_1, initial_vel_2]

end subroutine read_input

!-----------------------------------------------------------------------
!! Subroutine: read_input
!-----------------------------------------------------------------------
!! By
!!
!!----------------------------------------------------------------------
!! Input:
!!
!-----------------------------------------------------------------------
subroutine write_results()
    implicit none
    !....
end subroutine write_results


end module read_write
