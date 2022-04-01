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
subroutine read_input()
    implicit none

end subroutine read_input

subroutine write_probability_density(file_name, x_vector, wave_functions)
    implicit none
    character(len=*), intent(in) :: file_name
    real(dp), intent(in) :: x_vector(:), wave_functions(:,:)
    integer :: unit

    open(newunit=unit,file=trim(file_name))
    write(unit,'(4a28)') 'x', 'ground state', '1st excited', '2nd excited'
    ! ...
    ! ...
    close(unit)
    
end subroutine write_probability_density

subroutine print_energies(name, numerical, analytic)
    implicit none
    character(len=*), intent(in) :: name
    real(dp), intent(out) :: numerical(:), analytic(:)

    if (size(numerical) /= size(analytic)) then
        print*, "arrays size don't match in print_energies"
        stop
    endif

    print*, 'Comparing numerical and anlytic solutions in'
    print*, trim(name)
    print*, 
    print'(a9,2a15)', 'number', 'numerical', 'analytic'
    ! ...
    ! ...
end subroutine print_energies

subroutine write_woods_saxon_energies(file_name, n_points, length, r_min, r_max)
    implicit none
    character(len=*), intent(in) :: file_name
    integer, intent(in) :: n_points
    real(dp), intent(in) :: length, r_min, r_max

    ! ...
    ! ... 
end subroutine write_woods_saxon_energies


end module read_write
