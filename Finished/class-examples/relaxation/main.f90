program relaxation_example
use types
implicit none

real(dp) :: x
integer :: i

x = 0.5_dp
print*, x
do i = 1, 80
    ! x = 2 - exp(-x)
    ! x = exp(1 - x**2)
    x = sqrt(1 - log(x))
    print*, x
enddo

contains


end program relaxation_example
