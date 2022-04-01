program mc_pi
    use iso_fortran_env
    implicit none
    integer, parameter :: dp = REAL64
    integer, parameter :: n_samples = 100000000
    real(dp), parameter :: r = 1._dp
    real(dp) :: x, y, d, pi
    integer :: k, i
    k = 0
    do i = 1, n_samples
        call random_number(x)
        call random_number(y)
        x = 2*r*x - r
        y = 2*r*y - r
        d = sqrt(x**2 + y**2)
        if (d <= r) then
            ! Inside of the circle
            k = k + 1
        endif
    enddo
    pi = (4._dp*k)/real(n_samples, kind=dp)
    print*, pi
end program mc_pi