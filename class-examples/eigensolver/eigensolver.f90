module eigensolver
use types
implicit none
private
public construct_tridiagonal, solve_eigenproblem
contains

subroutine construct_tridiagonal(d,e)
    implicit none
    real(dp), intent(out) :: d(:),e(:)
    
    d = [1._dp, 2._dp, 3._dp, 4._dp, 5._dp]

    e = [6._dp, 7._dp, 8._dp, 9._dp]

end subroutine construct_tridiagonal

subroutine solve_eigenproblem(d, e, lambdas, vectors)
    implicit none
    real(dp), intent(in) :: d(:), e(:)
    real(dp), intent(out) :: lambdas(:), vectors(:,:)
    character(len=1), parameter :: jobz = 'V'
    integer :: n
    real(dp), allocatable :: e_work(:), work(:)
    integer :: info

    n = size(d)

    allocate(e_work(1:n-1))
    allocate(work(1: 2*n - 2))

    lambdas = d
    e_work = e
    call dstev(jobz, n, lambdas, e_work, vectors, n, work, info)

    if (info /= 0) then
        print*, 'Error when calling dstev.'
        print*, 'Info = ', info
        stop
    endif

end subroutine solve_eigenproblem
end module eigensolver