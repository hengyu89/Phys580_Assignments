!-----------------------------------------------------------------------
!Module: read_write
!-----------------------------------------------------------------------
!! By: Noah
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
! use OMP_LIB
implicit none

private
public :: read_input, write_potential, print_wall_clock_time

contains

!-----------------------------------------------------------------------
!! Subroutine: read_input
!-----------------------------------------------------------------------
!! By: Noah
!!
!! Describe what the subroutine does
!!
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine read_input(length, rho_zero, center, width, n_max, n_samples, output_file)
    implicit none
    real(dp), intent(out) :: length(1:2)
    real(dp), intent(out) :: rho_zero
    real(dp), intent(out) :: center(1:2), width(1:2)
    integer, intent(out) :: n_max, n_samples
    
    integer :: n_arguments, unit, ierror
    character(len = 1024) :: output_file
    character(len = 1024) :: namelist_file
    logical :: file_exists

    namelist /box/ length 
    namelist /charge_distribution/ rho_zero, center, width
    namelist /sampling/ n_max, n_samples
    namelist /output/ output_file
    

    ! Setting default values
    length = [5._dp, 5._dp]
    rho_zero = 1._dp
    center = [3._dp, 3._dp]
    width = [1._dp, 1._dp]
    n_max = 101
    n_samples = 97
    output_file = 'output.dat'


    n_arguments = command_argument_count()

    if (n_arguments == 1) then
        call get_command_argument(1, namelist_file)
        inquire(file=trim(namelist_file), exist = file_exists)
        if (file_exists) then
            open(newunit = unit, file = namelist_file)
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
            read(unit, nml = output, iostat = ierror)
            if (ierror /= 0) then
                print*, 'Error reading output in namelist.'
                stop
            end if
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
!! By: Noah
!!
!! Describe what the subroutine does
!!
!!----------------------------------------------------------------------
!! Input:
!!
!! c_fourier        real        2D array of Fourier coefficients
!! length           real        1D array containing length/width of box
!! file_name        string      output file name
!-----------------------------------------------------------------------
!!----------------------------------------------------------------------
!! Output:
!! 
!-----------------------------------------------------------------------
subroutine write_potential(c_fourier, length, file_name)
    implicit none
    real(dp) :: delta_x, delta_y
    character(len=*), intent(in) :: file_name
    real(dp), intent(in) :: c_fourier(:,:), length(:)
    real(dp), allocatable :: x(:), y(:), v(:,:) 
    integer :: n_shape(1:2), n, i, j, unit
    n_shape = shape(c_fourier)
    n = n_shape(1)
    allocate(x(n), y(n), V(n,n))

    if (n_shape(1) /= n_shape(2)) then
        print*, 'Error in module read_write,'
        print*, 'subroutine write_potential:'
        print*, 'c_fourier must be square.'
    endif

    ! Define step size in x and y directions
    delta_x = length(1)/n
    delta_y = length(2)/n


    !$omp parallel default(none) private(i,j) shared(c_fourier, length, file_name, delta_x, delta_y, x, y, v, n, unit)
    !$omp do schedule(dynamic)

    do i = 1, n
        if (i == 1) then
            x(i) = 0._dp
        else 
            x(i) = x(i - 1) + delta_x
        end if
        do j = 1, n
            if (j == 1) then
                y(j) = 0._dp
            else
                y(j) = y(j-1) + delta_y
            end if
            v(i,j) = phi_potential(c_fourier, length, x(i), y(j))
        enddo
    enddo

    !$omp end do 
    !$omp end parallel

    ! Write potential to a file
    open(newunit = unit, file = file_name, status = 'unknown')
    write(unit, '(9a25)') 'x:', 'y:', 'v:'
    do i = 1, N
        write(unit, *) x(i), y(i), v(i, :)
    end do
    close(unit)

end subroutine write_potential

!-----------------------------------------------------------------------
!! Subroutine: print_wall_clock_time
!-----------------------------------------------------------------------
!! By: Noah
!!
!! Describe what the subroutine does
!!
!!----------------------------------------------------------------------
!! Input:
!!
!! count_1      integer     system clock time before program execution
!! count_2      integer     system clock time after program execution
!! count_rate   integer     number of system clock counts per second
!-----------------------------------------------------------------------
!!----------------------------------------------------------------------
!! Output:
!!
!-----------------------------------------------------------------------
subroutine print_wall_clock_time(count_1, count_2, count_rate)
    implicit none
    integer, intent(in) :: count_1, count_2, count_rate
    
    print *, 'Program run time: ', (count_2 - count_1)/real(count_rate, kind=dp), 'seconds'
end subroutine print_wall_clock_time

!!----------------------------------------------------------------------
!! Subroutine: write_wall_clock_time
!!----------------------------------------------------------------------
!! By: Noah
!!
!! This subroutine finds the total time elapsed in seconds to run the
!! program and writes it to file 
!!----------------------------------------------------------------------
!! Input:
!! 
!! count_1      integer     system clock time before program execution
!! count_2      integer     system clock time after program execution
!! count_rate   integer     number of system clock counts per second
!! file_name    string      Output file to write elapsed time to
!! num_threads  integer     Current number of threads used in parallelization
!!----------------------------------------------------------------------
subroutine write_wall_clock_time(count_1, count_2, count_rate, file_name, num_threads)
    implicit none
    integer, intent(in) :: count_1, count_2, count_rate
    character(len=*) :: file_name
    integer :: unit, num_threads

    open(unit=3, file = file_name, access='append')
    write(3,'(I5,F7.2)') num_threads, (count_2-count_1)/real(count_rate,kind=dp)
    close(3)

end subroutine write_wall_clock_time

end module read_write
