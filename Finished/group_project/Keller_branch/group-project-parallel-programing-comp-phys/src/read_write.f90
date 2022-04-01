!-----------------------------------------------------------------------
!Module: read_write
!-----------------------------------------------------------------------
!! By: 
!!
!! Explain the subroutines and functions included in the module
!!----------------------------------------------------------------------
!! Included subroutines:
!!
!! 
!!----------------------------------------------------------------------
!! Included functions:
!!
!! 
!-----------------------------------------------------------------------
module read_write
use types
use potential, only : phi_potential
implicit none

private
public :: read_input, write_potential, print_wall_clock_time

contains

!-----------------------------------------------------------------------
!! Subroutine: read_input
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine read_input(length, rho_zero, center, width, n_max, n_samples)
    implicit none
    real(dp), intent(out) :: length(1:2)
    real(dp), intent(out) :: rho_zero
    real(dp), intent(out) :: center(1:2), width(1:2)
    integer, intent(out) :: n_max, n_samples
    
    integer :: n_arguments, unit, ierror
    character(len=1024) :: namelist_file
    logical :: file_exists

    namelist /box/ length, n_samples
    namelist /charge_distribution/ rho_zero, center, width
    namelist /sampling/ n_max, n_samples


    ! Setting default values
    length = [5._dp, 5._dp]
    rho_zero = 1._dp
    center = [3._dp, 3._dp]
    width = [1._dp, 1._dp]
    n_max = 100
    n_samples = 97


    n_arguments = command_argument_count()

    if (n_arguments == 1) then
        call get_command_argument(1, namelist_file)
        inquire(file=trim(namelist_file), exist = file_exists)
        if (file_exists) then
            open(newunit = unit, file = namelist_file )

            read(unit, nml = box, iostat = ierror)
            if(ierror /= 0) then
                print*, 'Error reading box namelist'
                stop
            endif
            read(unit, nml = charge_distribution, iostat = ierror)
            if(ierror /= 0) then
                print*, 'Error reading charge_distribution namelist'
                stop
            endif
            read(unit, nml = sampling, iostat = ierror)
            if(ierror /= 0) then
                print*, 'Error reading sampling namelist'
                stop
            endif

            close(unit)
        else
            print*, 'Argument, ', trim(namelist_file)
            print*, 'does not exist. Ending program'
            stop
        endif
    elseif(n_arguments /= 0) then
        print*, 'Incorrect number of arguments'
        print*, 'The program takes either 0 or 1 arguments'
        print*, 'See documentation on README.md for details'
        stop
    endif

end subroutine read_input

!-----------------------------------------------------------------------
!! Subroutine: write_potential
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!
!!----------------------------------------------------------------------
!! Input:
!!
!-----------------------------------------------------------------------
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine write_potential(c_fourier, length, n_samples, file_name)
    implicit none
    character(len=*), intent(in) :: file_name
    real(dp), intent(in) :: c_fourier(:,:), length(:)
    integer, intent(in) :: n_samples

    real(dp) :: potential, x, y, delta_x, delta_y
    integer :: n_shape(1:2), n, unit, n_max, i_x, i_y

    n_shape = shape(c_fourier)
    n = n_shape(1)

    delta_x = length(1)/n_samples
    delta_y = length(2)/n_samples

    open(newunit = unit, file = trim(file_name))

    ! number of headers: 6, number of spaces: 18
    ! write(unit,*) 'The initial conditions used: '
    ! write(unit,*) 'Inital Time: ', t_i
    ! write(unit,*) 'Inital Position of Object 1: ', q_i(1), q_i(2)
    ! write(unit,*) 'Inital Position of Object 2: ', q_i(3), q_i(4)
    ! write(unit,*) 'Inital Velocity of Object 1: ', q_i(5), q_i(6)
    ! write(unit,*) 'Inital Velocity of Object 2: ', q_i(7), q_i(8)

    !write, q_i

    write(unit,*) ! To space out output and initial conditions

    write(unit,'(3a20)') 'x', 'y', 'potential'
    x = 0._dp
    y = 0._dp

    do i_x = 0, n_samples
        do i_y = 0, n_samples
            potential = phi_potential(c_fourier, length, x, y)
            write(unit,*) x, y, potential
            y = y + delta_y
        enddo
        x = x + delta_x
        y = 0._dp
    enddo

    print *, 'The results were written into poisson.dat'

end subroutine write_potential

!-----------------------------------------------------------------------
!! Subroutine: print_wall_clock_time
!-----------------------------------------------------------------------
!! By:
!!
!! Describe what the subroutine does
!!
!!----------------------------------------------------------------------
!! Input:
!!
!-----------------------------------------------------------------------
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine print_wall_clock_time(count_1, count_2, count_rate)
    implicit none
    integer, intent(in) :: count_1, count_2, count_rate
    
    print *, 'Program run time: ', count_2 - count_1
end subroutine print_wall_clock_time

end module read_write
