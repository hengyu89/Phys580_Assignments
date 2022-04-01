program odes_example
use types
implicit none

integer, parameter :: n=500
real(dp) :: r(1:2), t_i, t_f, h, t, k1(1:2), k2(1:2)
integer :: unit, i
real(dp), parameter :: alpha=1._dp, beta=0.9_dp, gamma=0.1_dp, delta= 2._dp

t_i = 0._dp
t_f = 30._dp
h = (t_f - t_i)/n

r = [1._dp, 4._dp]

open(newunit = unit, file = 'lv_solution.dat')
    write(unit,'(3e25.8)') t, r 
    do i=1,n
        k1 = h*func(r, t)
        k2 = h*func(r + k1/2, t + h/2)
        r = r + k2
        t = t + h
        write(unit,'(3e25.8)') t, r
    enddo
close(unit)

contains

function func(x, t) result(f)
    implicit none
    real(dp), intent(in) :: x(:), t
    real(dp), allocatable :: f(:)
    allocate(f(1:size(x)))
    f(1) = alpha*x(1) - beta*x(1)*x(2)
    f(2) = gamma*x(1)*x(2) - delta*x(2)
end function func

end program odes_example

