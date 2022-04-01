program openmp_example
use types
use fourier, only :  dft, fft
use monte_carlo, only: monte_carlo_pi
implicit none

integer, parameter :: n_size = 2**13
integer, parameter :: n_pi = 1000000000
complex(dp), parameter :: ii = (0, 1)
complex(dp), dimension(n_size) :: y 
complex(dp), dimension(n_size) :: c 
integer :: i, count_1, count_2, count_rate, max_count
real(dp) :: a, b, time
real(dp) :: mc_pi

print*, n_size

do i=1,n_size
    call random_number(a)
    call random_number(b)
    y(i) = a + ii*b
enddo

! computes the Discrete Fourier Transform of
! y and returns it in c (brute force method)
call system_clock(count_1, count_rate, max_count)
call dft(y,c)
call system_clock(count_2, count_rate, max_count)
time = (count_2 - count_1)/real(count_rate, kind=dp)

print'(a,1f15.8)', 'dft calculation time: ', time

! computes the Fast Fourier Transform of
! y and returns it in y
call system_clock(count_1, count_rate, max_count)
call fft(y)
call system_clock(count_2, count_rate, max_count)
time = (count_2 - count_1)/real(count_rate, kind=dp)

print'(a,1f15.8)', 'fft calculation time: ', time

! !comparing the output of both methods
! do i=1,n_size
!     print'(2f15.8)',  y(i) - c(i)
! end do


call system_clock(count_1, count_rate, max_count)
call monte_carlo_pi(n_pi, mc_pi)
call system_clock(count_2, count_rate, max_count)
time = (count_2 - count_1)/real(count_rate, kind=dp)

print'(a,1f15.8)', 'mc  calculation time: ', time
print'(a,1f15.8)', 'monte carlo pi: ', mc_pi


end program openmp_example