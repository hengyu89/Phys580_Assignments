module monte_carlo
use types
implicit none

private

public monte_carlo_pi

contains

subroutine monte_carlo_pi(n_samples, mc_pi)
    implicit none
    integer, intent(in) :: n_samples
    real(dp), intent(out) :: mc_pi
    integer :: k, i
    real(dp), parameter :: r = 1._dp
    real(dp) :: x, y, d
    integer :: all_counts(1:8)
    integer :: thread_id, num_threads
    integer :: omp_get_thread_num, omp_get_num_threads

all_counts = 0

!$omp parallel default(none) private(thread_id, i, x, y, d, k) &
!$omp shared(all_counts, n_samples, num_threads)
    thread_id = omp_get_thread_num()
    num_threads = omp_get_num_threads()
    k = 0
    do i = 1, n_samples/num_threads
        call random_number(x)
        call random_number(y)
        x = 2*r*x - r
        y = 2*r*y - r
        d = sqrt(x**2 + y**2)
        if (d <= r) then
            ! Inside of the circle of radius r
            k = k + 1
        endif
    enddo
    all_counts(thread_id + 1) = k
!$omp end parallel

    k = sum(all_counts)
    mc_pi = (4._dp*k)/real(n_samples,kind=dp)
    
end subroutine monte_carlo_pi
    
end module monte_carlo
