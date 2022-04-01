module fourier
use types
implicit none

complex(dp), parameter :: ii = (0, 1)

private

public dft, fft

contains

subroutine dft(y, c)
    implicit none
    complex(dp), intent(in) :: y(:)
    complex(dp), intent(out) :: c(:)
    integer :: n, k, n_samples, i, j
    n_samples = size(y)

    c = (0, 0)

    do i = 1, n_samples
        k = i - 1
        do j = 1, n_samples
            n = j - 1
            c(i) = c(i) + y(j)*exp(-2*pi*ii*k*n/real(n_samples, kind=dp))
        enddo
    enddo
    
end subroutine dft

recursive subroutine fft(y)
    implicit none
    complex(dp), intent(inout) :: y(:)
    integer :: n_samples
    complex :: twiddle
    complex(dp), allocatable :: even(:), odd(:)
    integer :: i, k

    n_samples = size(y)

    if (n_samples .le. 1) return

    allocate(even(1:n_samples/2))
    allocate(odd(1:n_samples/2))

    do i = 1, n_samples/2
        even(i) = y(2*i - 1)
        odd(i) = y(2*i)
    enddo

    call fft(even)
    call fft(odd)

    do i=1, n_samples/2
        k = i - 1
        twiddle = exp(-ii*2*pi*k/real(n_samples, kind=dp))
        y(i) = even(i) + twiddle*odd(i)
        y(i + n_samples/2) = even(i) - twiddle*odd(i)
    enddo


end subroutine fft


end module fourier





















! recursive subroutine fft(y)
!     implicit none
!     complex(dp), intent(inout) :: y(:)
!     integer :: i, k, n_samples
!     complex(dp) :: twiddle
!     complex(dp), allocatable :: even(:), odd(:)

!     n_samples = size(y)

!     if(n_samples .le. 1) return

!     allocate(even(n_samples/2))
!     allocate(odd(n_samples/2))

!     do i=1,n_samples/2
!         even(i) = y(2*i -1)
!         odd(i) = y(2*i)
!     enddo

!     call fft(even)
!     call fft(odd)

!     do i=1,n_samples/2
!         k = i -1
!         twiddle = exp(-2*pi*ii*k/real(n_samples,kind = dp))
!         y(i) = even(i) + twiddle*odd(i)
!         y(i+n_samples/2) = even(i) - twiddle*odd(i)
!     enddo


! end subroutine fft