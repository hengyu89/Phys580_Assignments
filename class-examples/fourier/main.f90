program fft_example
use types
use fourier, only :  dft, fft
implicit none

integer, parameter :: n_size = 2**13
complex(dp), parameter :: ii = (0, 1)
complex(dp), dimension(n_size) :: y 
complex(dp), dimension(n_size) :: c 
integer :: i
real(dp) :: a, b, start, finish

print*, n_size

do i=1,n_size
    call random_number(a)
    call random_number(b)
    y(i) = a + ii*b
enddo

! computes the Discrete Fourier Transform of
! y and returns it in c (brute force method)
call cpu_time(start)
call dft(y,c)
call cpu_time(finish)

print'(a, 1f15.8)', 'calculation time:', finish - start

! computes the Fast Fourier Transform of
! y and returns it in y
call cpu_time(start)
call fft(y)
call cpu_time(finish)

print'(a, 1f15.8)', 'calculation time:', finish - start

! comparing the output of both methods
! do i=1,n_size
!     print'(2f15.8)',  y(i) - c(i)
! end do

end program fft_example