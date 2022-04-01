!-----------------------------------------------------------------------
!Module: read_write
!-----------------------------------------------------------------------
!! Rodrigo Navarro Perez
!!
!! Contains subroutines and functions related to reading input from the
!! user and  writing output into a text file
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
use qm_solver, only: solve_woods_saxon
implicit none

private
public :: read_input, write_probability_density, print_energies, write_woods_saxon_energies

contains

!-----------------------------------------------------------------------
!! Subroutine: read_input
!-----------------------------------------------------------------------
!! Rodrigo Navarro Perez
!!
!! Displays a message describing what the program does and the expected
!! input. After that it uses the `read_real` and `read_integer`
!! functions to assign values to the different parameters.
!!----------------------------------------------------------------------
!! Output:
!!
!! n_points     integer     number of grid points the discretized wave function
!! length       real        length of the box
!! radius       real        radius of the Woods-Saxon potential
!-----------------------------------------------------------------------
subroutine read_input(n_points, length, radius)
    implicit none
    integer, intent(out) :: n_points
    real(dp), intent(out) :: length, radius

    print *, 'This program calculates the rigenenergies and eigenfunctions for the Woods Saxon potential as the ultimate goal....'
    print *, 'At first, please write the number of points, length and radius values as you expect.'

    n_points = read_integer('n_points n --->')
    length = read_real('Length of the well L --->')
    radius = read_real('Radius r --->')
    print *, ''

end subroutine read_input

!-----------------------------------------------------------------------
!! Function: read_real
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! Check the input from user whether it's a real number or not, and it 
!! will return a warning if the output is not a real number the program e
!! xpected.
!!-----------------------------------------------------------------------
!! Input:
!!
!! name     character   A string with a brief description of the value 
!!                      being asked for
!!-----------------------------------------------------------------------
!! Output:
!!
!! x        real        A positive non negative number given by the user
!-----------------------------------------------------------------------
real(dp) function read_real(name) result(x)!!----------------------------------------------------------------------How to know it's integer or real?
    implicit none
    character(len=*), intent(in) :: name
    character(len=120) :: string
    integer :: ierror

    print *, 'Provide a nonzero positive value for the '//trim(name)//':'

    do
        read(*,'(a)', iostat=ierror) string
        if(string /= '') then
            read(string,*,iostat=ierror) x
            if(ierror == 0) exit
            print *, "'"//trim(string)//"'"//' is not a real number, please provide a number'
        else
            print *, 'That was an empty input, please provide a number'
        endif
    enddo
end function read_real

!-----------------------------------------------------------------------
!! Function: read_integer
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! Check the input from user whether it's a integer number or not, and it 
!! will return a warning if the output is not a integer number the program e
!! xpected.
!!-----------------------------------------------------------------------
!! Input:
!!
!! name     character   A string with a brief description of the value 
!!                      being asked for
!!-----------------------------------------------------------------------
!! Output:
!!
!! x        real        A positive non negative number given by the user
!-----------------------------------------------------------------------
integer function read_integer(name) result(x)!!----------------------------------------------------------------------How to know it's integer or real?
    implicit none
    character(len=*), intent(in) :: name
    character(len=120) :: string
    integer :: ierror

    print *, 'Provide a nonzero positive value for the '//trim(name)//':'

    do
        read(*,'(a)', iostat=ierror) string
        if(string /= '') then
            read(string,*,iostat=ierror) x
            if(ierror == 0) exit
            print *, "'"//trim(string)//"'"//' is not a interger number, please provide a number'
        else
            print *, 'That was an empty input, please provide a number'
        endif
    enddo
end function read_integer

!-----------------------------------------------------------------------
!! subroutine: write_probability_density
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! Write a .dat file about the probability density with the name given by user. The .dat file includes 
!! the database of x, ground state, 1st excited and 2nd excited.
!!-----------------------------------------------------------------------
!! Input:
!!
!! file_name        character       A string of file name given by the user
!! x_vector         real            Array containing the x values as non negative number of x
!! wave_functions   real            Array containing the result of wave function coressponding to the x value
!-----------------------------------------------------------------------
subroutine write_probability_density(file_name, x_vector, wave_functions)
    implicit none
    character(len=*), intent(in) :: file_name
    real(dp), intent(in) :: x_vector(:), wave_functions(:,:)
    integer :: unit, i

    open(newunit=unit,file=trim(file_name))
    write(unit,'(4a28)') 'x', 'ground state', '1st excited', '2nd excited'

    do i=1, size(x_vector)
        write(unit, '(4e28.16)') x_vector(i), wave_functions(i,1)**2, wave_functions(i,2)**2, wave_functions(i,3)**2
    enddo

    close(unit)

    !print *, ''
    !print *, ''
    
end subroutine write_probability_density

!-----------------------------------------------------------------------
!! subroutine: print_energies
!-----------------------------------------------------------------------
!! Heng Yu
!!
!! The subroutine will print the value of x values, numerical energies and analytic energies on the screen separately.
!!-----------------------------------------------------------------------
!! Input:
!!
!! name             character           A string of name that users put into in order to getting corresponding name of energies.
!!-----------------------------------------------------------------------
!! Output:
!!
!! numerical        real(dp)            Vecotr contains the first three state numerical energies.
!! analytic         real(dp)            Vector contains the first three state analytic energies.
!-----------------------------------------------------------------------
subroutine print_energies(name, numerical, analytic)
    implicit none
    character(len=*), intent(in) :: name
    real(dp), intent(out) :: numerical(:), analytic(:)
    integer :: i

    if (size(numerical) /= size(analytic)) then
        print*, "arrays size don't match in print_energies"
        stop
    endif

    print*, 'Comparing numerical and anlytic solutions in'
    print*, trim(name)
    !print*, 
    print'(a12,2a22)', 'number', 'numerical', 'analytic'
    do i=1, size(numerical)
        print *, i, numerical(i), analytic(i)
    enddo

end subroutine print_energies

subroutine write_woods_saxon_energies(file_name, n_points, x_vector, length, r_min, r_max)
    implicit none
    character(len=*), intent(in) :: file_name
    integer, intent(in) :: n_points
    real(dp), intent(in) :: length, r_min, r_max, x_vector(:)
    real(dp) :: dr, radius, energies(1:3), wave_functions(1:size(x_vector),1:3)                           ! I'm not sure how to connect the n_energies into this subroutine so I just write 3 here.
    real(dp) :: potential_depth, surface_thickness
    integer :: unit, i

    dr = (r_max-r_min)/(n_points-1)
    radius = r_min - dr
    ! first = 0
    ! second = 2*length/(n_points-1)
    ! third = 2*second
    potential_depth = 50
    surface_thickness = 0.2

    open(newunit=unit,file=trim(file_name))
    write(unit,'(4a28)') 'Radius', 'ground state', 'first excited', 'second excited'

    do i=1, n_points
        radius = radius + dr

        call solve_woods_saxon(n_points, length, radius, x_vector, wave_functions, energies)

        ! ground_state   = -potential_depth/(1 + exp( (first-radius) / surface_thickness ))
        ! first_excited  = -potential_depth/(1 + exp( (second-radius) / surface_thickness ))
        ! second_excited = -potential_depth/(1 + exp( (third-radius) / surface_thickness ))

        write(unit, '(4e28.16)') radius, energies(1), energies(2), energies(3)
    enddo

    close(unit)


    ! ...
    ! ... 
end subroutine write_woods_saxon_energies


end module read_write
