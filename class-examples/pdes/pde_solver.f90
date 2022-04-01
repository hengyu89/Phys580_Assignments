module pde_solver
use types
implicit none

private 

public :: heat_equation, wave_equation

contains

function heat_equation(x, t, work) result(f)
    implicit none
    real(dp), intent(in) :: x(:), t, work(:)
    real(dp), allocatable :: f(:)
    real(dp) :: D, a
    integer :: i
    allocate(f, mold=x)
    D = work(1)
    a = work(2)
    f = 0
    do i = 2, size(x) - 1
        f(i) = D/a**2*(x(i-1) + x(i+1) - 2*x(i))
    enddo

end function heat_equation

function wave_equation(x, t, work) result(f)
    implicit none
    real(dp), intent(in) :: x(:), t, work(:)
    real(dp), allocatable :: f(:)

    real(dp) :: v, a
    integer :: i, n

    n = size(x)/2

    allocate(f, mold=x)

    v = work(1)
    a = work(2)

    f(1 : n) = x(n + 1 : 2*n)

    do i = 2, n - 1
        f(n + i) = (v**2)/(a**2)*(x(i - 1) + x(i + 1) - 2*x(i))
    enddo
end function wave_equation

end module pde_solver

