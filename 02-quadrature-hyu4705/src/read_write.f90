!-----------------------------------------------------------------------
!Module: read_write
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe the purpose of the subroutines in this module
!!----------------------------------------------------------------------
!! Included subroutines:
!!
!! read_input
!! read_advanced_input
!!----------------------------------------------------------------------
!! Included functions:
!!
!! read_real
!! read_integer
!-----------------------------------------------------------------------
module read_write
use types
use neutron_flux, only : box_flux_booles, large_x0_flux, box_flux_monte_carlo!, total_flux_booles, hollow_box_flux_mc

implicit none

private
public :: read_input, write_neutron_flux!, read_advanced_input, write_advanced_flux

contains

!-----------------------------------------------------------------------
!! Subroutine: read_input
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what this subroutine does
!!----------------------------------------------------------------------
!! Output:
!!
!! depth        real        Depth of the rectangular nuclear reactor
!! width        real        Width of the rectangular nuclear reactor
!! height       real        Height of the rectangular nuclear reactor
!! y_zero       real        y coordinate of the detector's position
!! x_min        real        minimum x coordinate of the detector's position
!! x_max        real        maximum x coordinate of the detector's position
!! x_step       real        increment size for the x coordinate of the detector's position
!! n_grid       integer     number of grid points in each dimension of Boole's integration
!! m_samples    integer     number of sample points in the Monte Carlo integration
!-----------------------------------------------------------------------
subroutine read_input(depth, width, height, y_zero, x_min, x_max, x_step, n_grid, m_samples)
    implicit none
    real(dp), intent(out) :: depth, width, height, y_zero, x_min, x_max, x_step
    integer, intent(out) ::  n_grid, m_samples

    ! use the print statement to give a message to the user describing
    ! what the program does and what input should the user give to the
    ! program  
    print *, 'This program calculates neutron flux of a reactor ....'

    ! In assignment 01 there was a single input and we used a do loop 
    ! to ask for such input. The loop was only exited once the input given
    ! was the correct one (the user had to give an actual number)
    ! and we put that loop directly in this function.

    ! However, here we need several inputs from the user, it wouldn't 
    ! make sense to write a do loop for each input needed. Instead 
    ! it's more efficient to put such loop inside a function and have
    ! such function return the input given by the user. 

    ! In order to ask for a different input in the screen, the new function
    ! we'll define below will take a string as input with the name of the
    ! variable we want the user to give us.
    depth = read_real('depth D')
    width = read_real('width W')
    ! height = read_real(...)
    ! y_zero = ...
    ! ...
    ! make sure to get a value for every real number the user needs to give

    ! The function read_real used above returns a double precision real,
    ! however n_grin and m_samples are integers, that means that we need
    ! another function to get integers. For that we'll define read_integer
    ! as well
    n_grid = read_integer('number of lattice points N')
    m_samples = read_integer('number Monte Carlo samples M')

    print *,
end subroutine read_input

!-----------------------------------------------------------------------
!! Function: read_real
!-----------------------------------------------------------------------
!! By:
!!
!! Give a description of what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! name     character   A string with a brief description of the value being asked for
!!----------------------------------------------------------------------
!! Output:
!!
!! x        real        A positive non negative number given by the user
!-----------------------------------------------------------------------
real(dp) function read_real(name) result(x)
    implicit none
    character(len=*), intent(in) :: name
    ! ... :: string
    ! ... :: ierror

    print *, 
    print *, 'Provide a nonzero positive value for the '//trim(name)//':'

    ! Use the do loop from assignment 01 to get an input from the user.
    ! Also, modify accordingly to make sure that the input is a non zero 
    ! positive number (there's no box with height H = -4.5 or width W = 0)

    ! Remember to declare above the type fro `string` and `ierror`

    ! do
    !     read(*,'(a)',iostat=ierror) string
    !     ...
    ! enddo
end function read_real

!-----------------------------------------------------------------------
!! Function: read_integer
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what the function does
!!----------------------------------------------------------------------
!! Input:
!!
!! name     character   A string with a brief description of the value being asked for
!!----------------------------------------------------------------------
!! Output:
!!
!! x        integer     A positive non negative number given by the user
!-----------------------------------------------------------------------
integer function read_integer(name) result(x)
    implicit none
    character(len=*), intent(in) :: name
    ! ... :: string
    ! ... :: ierror

    print *,
    print *, 'Provide a nonzero positive value for the '//trim(name)//':'

    ! Here you can use the same structure that you used in read_real.
    ! The fact that we declared x as an integer will take care of 
    ! checking that the number is an actual integer

    ! Also, put checks to make sure that the user gives positive non zero integers
    ! You can't integrate with -17 grid points! 

    ! Remember to declare above what type of variables string and ierror are

    ! do
    !     read(*,'(a)',iostat=ierror) string
    !     ...
    ! enddo
end function read_integer

!-----------------------------------------------------------------------
!Subroutine: write_neutron_flux
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
!! y_zero       real        y coordinate of the detector's position
!! x_min        real        minimum x coordinate of the detector's position
!! x_max        real        maximum x coordinate of the detector's position
!! x_step       real        increment size for the x coordinate of the detector's position
!! n_grid       integer     number of grid points in each dimension of Boole's integration
!! m_samples    integer     number of sample points in the Monte Carlo integration
!-----------------------------------------------------------------------
subroutine write_neutron_flux(depth, width, height, y_zero, x_min, x_max, x_step, n_grid, m_samples)
    implicit none
    real(dp), intent(in) :: depth, width, height, y_zero, x_min, x_max, x_step
    integer, intent(in) :: n_grid, m_samples

    real(dp) :: x_zero, box_booles, box_mc, box_large_x0, sigma_box
    character(len=*), parameter :: file_name = 'results_basic.dat'
    integer :: unit

    open(newunit=unit,file=file_name)
    write(unit,'(5a28)') 'x_0', 'booles', 'large x_0', 'monte carlo', 'MC uncertainty'
    x_zero = x_min
    do 
        if(x_zero > x_max) exit
        box_booles = box_flux_booles(depth, width, height, x_zero, y_zero, n_grid)
        box_large_x0 = large_x0_flux(depth, width, height, x_zero, y_zero)
        call box_flux_monte_carlo(depth, width, height, x_zero, y_zero, m_samples, box_mc, sigma_box)
        write(unit,'(5e28.16)') x_zero, box_booles, box_large_x0, box_mc, sigma_box
        x_zero = x_zero + x_step
    enddo
    close(unit)
    print *, 'The fluxes were written in the '//file_name//' file'
    print *,
end subroutine write_neutron_flux

! Below are the read and write subroutines for the advanced part the project.
! Remember to make them public at the top of the module. And to also `use` them
! in the main program

!-----------------------------------------------------------------------
!! Subroutine: read_advanced_input
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what the subroutine does
!!----------------------------------------------------------------------
!! Output:
!!
!! x_zero       real        x coordinate of the detector's position
!! r_min        real        minimum radius of the hollow sphere
!! r_max        real        maximum radius of the hollow sphere
!! r_step       real        increment size for the radius of the hollow sphere
!-----------------------------------------------------------------------
! subroutine read_advanced_input(x_zero, r_min, r_max, r_step)
!     implicit none
!     real(dp), intent(out) :: x_zero, r_min, r_max, r_step

!     ! Base this new subroutine on the read_input one
! end subroutine read_advanced_input

!-----------------------------------------------------------------------
!Subroutine: write_advanced_flux
!-----------------------------------------------------------------------
!! By: 
!!
!! Describe what the subroutine does
!!----------------------------------------------------------------------
!! Input:
!! 
!! depth        real        Depth of the rectangular nuclear reactor
!! width        real        Width of the rectangular nuclear reactor
!! height       real        Height of the rectangular nuclear reactor
!! x_zero       real        x coordinate of the detector's position
!! y_zero       real        y coordinate of the detector's position
!! r_min        real        minimum radius of the hollow sphere
!! r_max        real        maximum radius of the hollow sphere
!! r_step       real        increment size for the radius of the hollow sphere
!! n_grid       integer     number of grid points in each dimension of Boole's integration
!! m_samples    integer     number of sample points in the Monte Carlo integration
!-----------------------------------------------------------------------
! subroutine write_advanced_flux(depth, width, height, x_zero, y_zero, r_min, r_max, r_step, n_grid, m_samples)
!     implicit none
!     real(dp), intent(in) :: depth, width, height, x_zero, y_zero, r_min, r_max, r_step
!     integer, intent(in) :: n_grid, m_samples

!     real(dp) :: radius, box_booles, hollow_booles, hollow_mc, sigma_hollow
!     character(len=*), parameter :: file_name = 'results_advanced.dat'
!     integer :: unit

!     open(newunit=unit, file=file_name)
!     write(unit,'(5a28)') 'radius', 'box booles', 'hollow booles', 'hollow monte carlo', 'MC uncertainty'
!     radius = r_min

!     box_booles = box_flux_booles(depth, width, height, x_zero, y_zero, n_grid)

!     ! The goal is to compare Boole's and Monte Carlo integration when there's a hollow 
!     ! sphere inside the reactor to the calculation of the solid reactor using Boole's method
!     ! Base the rest of the subroutine on the one from the basic part of the project.
! end subroutine write_advanced_flux

end module read_write
