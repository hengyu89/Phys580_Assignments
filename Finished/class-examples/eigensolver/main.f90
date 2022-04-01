program lapack_example
use types
use eigensolver, only: construct_tridiagonal, solve_eigenproblem
implicit none
integer, parameter :: n_dimensions = 5
real(dp) :: d_diagonal(1:n_dimensions)
real(dp) :: e_diagonal(1:n_dimensions-1)
real(dp) :: eigenvalues(1:n_dimensions)
real(dp) :: eigenvectors(1:n_dimensions,1:n_dimensions)
integer :: i

call construct_tridiagonal(d_diagonal,e_diagonal)
call solve_eigenproblem(d_diagonal,e_diagonal,eigenvalues,eigenvectors)

print*, 'eigenvalues:'
print'(5f15.8)', eigenvalues
print*, 

print*, 'eigenvectors'
do i = 1, n_dimensions
    print'(5f15.8)', eigenvectors(:,i)/eigenvectors(n_dimensions, i)
    print*, 
enddo
end program lapack_example