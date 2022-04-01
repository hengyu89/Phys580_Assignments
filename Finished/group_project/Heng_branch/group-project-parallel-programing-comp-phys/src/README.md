## Codes might be useful to put into the README.md file

### Parallel codes in potential:
```
    ! Parallelization implementation
    !$omp parallel default(none) private(m,n,rho_mn) & 
    !$omp & shared(length,rho_zero,norm,center,width,l_x,l_y,r_x,r_y,c_fourier,n_max, n_samples, num_threads)

    ! Get number of threads for time tests
    num_threads = OMP_GET_NUM_THREADS()

    !$omp do schedule(dynamic)

    ! Calculate the fourier coefficients by constructing a 2D array
    ! the contains the values of the coefficients for each m,n.
    do m = 1, n_max
        do n = 1, n_max
            rho_mn = norm*rho_zero*rho_mn_int(length, center, width, n_max, n_samples, m, n)
            c_fourier(m, n) = 4*pi*rho_mn/((m*pi/l_x)**2 + (n*pi/l_y)**2)
        enddo
    enddo

    !$omp end do
    !$omp end parallel
```

### Parallel codes in read_write:
```
    ! Parallelization implementation

    !$omp parallel default(none) private(i,j) &
    !$omp & shared(c_fourier, length, file_name, delta_x, delta_y, x, y, v, n, unit)
    !$omp do schedule(dynamic)

    do i = 1, n
        if (i == 1) then
            x(i) = 0._dp
        else 
            x(i) = x(i - 1) + delta_x
        end if
        do j = 1, n
            if (j == 1) then
                y(j) = 0._dp
            else
                y(j) = y(j-1) + delta_y
            end if
            v(i,j) = phi_potential(c_fourier, length, x(i), y(j))
        enddo
    enddo

    !$omp end do 
    !$omp end parallel
```

### Location needs 'n_max'
```
subroutine calculate_coefficients(length, rho_zero, center, width, n_max, n_samples, c_fourier, num_threads)
    implicit none
    real(dp), intent(in) :: length(1:2), center(1:2), width(1:2), rho_zero
    integer, intent(in) :: n_max, n_samples
    integer, intent(out) :: num_threads
    real(dp), allocatable, intent(out) :: c_fourier(:,:)
    real(dp) :: l_x, l_y, r_x, r_y, norm, rho_mn
    integer :: m, n, OMP_GET_NUM_THREADS

    allocate(c_fourier(1:n_max, 1:n_max))

    ! Define length and width of box, and length and width of charge source
    l_x = length(1)
    l_y = length(2)
    r_x = width(1)
    r_y = width(2)

    ! Define normalization constant
    norm = 2/sqrt(l_x*l_y)

    ! Parallelization implementation
    !$omp parallel default(none) private(m,n,rho_mn) & 
    !$omp & shared(length,rho_zero,norm,center,width,l_x,l_y,r_x,r_y,c_fourier,n_max, n_samples, num_threads)

    ! Get number of threads for time tests
    num_threads = OMP_GET_NUM_THREADS()

    !$omp do schedule(dynamic)

    ! Calculate the fourier coefficients by constructing a 2D array
    ! the contains the values of the coefficients for each m,n.
    do m = 1, n_max
        do n = 1, n_max
            rho_mn = norm*rho_zero*rho_mn_int(length, center, width, n_max, n_samples, m, n)
            c_fourier(m, n) = 4*pi*rho_mn/((m*pi/l_x)**2 + (n*pi/l_y)**2)
        enddo
    enddo

    !$omp end do
    !$omp end parallel

end subroutine calculate_coefficients
```

### Location needs 'n_samples'
```
real(dp) function rho_mn_int(length, center, width, n_max, n_samples, m, n) result(rho)
    implicit none
    real(dp), intent(in) :: length(1:2), center(1:2), width(1:2)
    integer, intent(in) :: n_max, n_samples, m, n
    real(dp), allocatable :: f_xy(:), f_x(:)
    real(dp) :: l_x, l_y, x, y, delta_x, delta_y
    integer :: i_y, i_x

    allocate(f_xy(1:n_samples))
    allocate(f_x(1:n_samples))

    ! Length and width of the box
    l_x = length(1)
    l_y = length(2)

    ! Define step sizes in the x and y directions 
    delta_x = l_x/(real(n_samples-1, kind=dp))
    delta_y = l_y/(real(n_samples-1, kind=dp))

    ! i_x index identifies index in the x-direction
    ! Outer loop
    do i_x = 1, n_samples
        x = (i_x - 1)*delta_x

        ! i_y index identifies index in the y-direction
        ! Inner loop
        do i_y = 1, n_samples 
            y = (i_y - 1)*delta_y

            ! Defines a 1-D array which contains the product of exponentials 
            ! and cosine functions for a specific x-value. The different values
            ! of the array correspond to the different y-values indexed by
            ! i_y.
            f_xy(i_y) = rho_xy(x, y, center, width)*cos((m*pi*x)/(l_x))*cos((n*pi*y)/(l_y))

       
        enddo

        ! Now, use booles_quadrature to itegrate over all y-values for
        ! a given i_x. Essentially, we are collapsing (integrating) 
        ! the 1-D array of y-values to form an element of the new array 
        ! where each element is indexed by i_x. Thus, we have a new
        ! array which contains the value of the products at each x
        ! indexed by i_x
        
        f_x(i_x) = booles_quadrature(f_xy, delta_y)

    enddo

    ! Perform the final integration over x.
    rho = booles_quadrature(f_x, delta_x)

end function rho_mn_int
```