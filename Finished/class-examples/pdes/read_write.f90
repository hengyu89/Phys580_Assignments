module read_write
use types
implicit none

private
public :: write_heat_results, write_wave_results

contains


subroutine write_heat_results(solution)
    implicit none
    real(dp), intent(in) :: solution(:,:)
    integer :: unit, i

    open(newunit = unit, file='results_heat.dat')
    do i = 1, size(solution, 1)
        write(unit,'(6e25.8e3)') solution(i, 10), solution(i, 100), solution(i, 500), solution(i, 1000), &
            solution(i, 2000), solution(i, 4000)
    enddo
    close(unit)
    
end subroutine write_heat_results


subroutine write_wave_results(solution)
    implicit none
    real(dp), intent(in) :: solution(:,:)
    integer :: unit, i

    open(newunit = unit, file='results_wave.dat')
    do i = 1, size(solution, 1)/2
        write(unit,'(7e25.8e3)') solution(i, 10), solution(i, 100), solution(i, 500), solution(i, 1000), &
            solution(i, 2000), solution(i, 4000)
    enddo
    close(unit)
    
end subroutine write_wave_results


end module read_write
