module ode_solver
use types
implicit none
private

public :: solve_euler

interface
    function func(r, t, work) result(f)
        use types, only : dp
        implicit none
        real(dp), intent(in) :: r(:), t, work(:)
        real(dp), allocatable :: f(:)
    end function func
end interface

contains

subroutine solve_euler(f, work, t_f, n, r_i, t, r)
    implicit none
    procedure(func) :: f
    real(dp), intent(in) :: work(:), t_f, r_i(:)
    integer, intent(in) :: n
    real(dp), intent(out), allocatable :: t(:), r(:,:)

    real(dp), allocatable :: r_sol(:)
    integer :: n_variables, i
    real(dp) :: h, t_sol

    n_variables = size(r_i)

    if(allocated(t)) deallocate(t)
    if(allocated(t)) deallocate(t)

    allocate(t(1:n))
    allocate(r(n_variables, n))
    allocate(r_sol(1:n_variables))

    h = t_f/n
    r_sol = r_i
    t_sol = 0._dp

    do i=1,n
        r_sol = r_sol + h*f(r_sol, t_sol, work)
        t_sol = t_sol + h
        t(i) = t_sol
        r(:, i) = r_sol
    enddo

end subroutine solve_euler

    
end module ode_solver