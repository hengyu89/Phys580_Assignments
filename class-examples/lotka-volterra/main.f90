program odes_example
use types
implicit none

integer :: n
real(dp) :: alpha,  beta, gamma, delta
real(dp) :: t_i, t_f
real(dp) :: r_i(1:2)
real(dp), allocatable :: t(:), r(:, :)
character(len=1024) :: fname

call set_parameters(alpha, beta, gamma, delta, t_i, t_f, r_i, n, fname)
call solve_runge_kutta(t_i, r_i, t_f, n, t, r)
call write_solution(fname, t_i, r_i, t, r)

contains

subroutine set_parameters(alpha, beta, gamma, delta, t_i, t_f, r_i, n, fname)
    implicit none
    real(dp), intent(out) :: alpha, beta, gamma, delta, t_i, t_f, r_i(1:2)
    integer, intent(out) ::  n
    character(len=*), intent(out) :: fname

    integer :: n_arguments, unit, ierror
    character(len=1024) :: namelist_file
    logical :: file_exists

    namelist /lotka_volterra/ alpha, beta, gamma, delta
    namelist /initial_conditions/ t_i, r_i
    namelist /integration/ t_f, n
    namelist /output/ fname

    ! Setting default values
    alpha = 1._dp
    beta = 0.5_dp
    gamma = 0.5_dp
    delta = 2._dp
    t_i = 0._dp
    t_f = 30._dp
    r_i = [1._dp, 4._dp]
    n = 500
    fname = 'lv_sol.dat'

    n_arguments = command_argument_count()

    if (n_arguments == 1) then
        call get_command_argument(1, namelist_file)
        inquire(file=trim(namelist_file), exist = file_exists)
        if (file_exists) then
            open(newunit = unit, file = namelist_file )
            read(unit, nml = lotka_volterra, iostat = ierror)
            if(ierror /= 0) then
                print*, 'Error reading lotka_volterra namelist'
                stop
            endif
            read(unit, nml = initial_conditions, iostat = ierror)
            if(ierror /= 0) then
                print*, 'Error reading initial_conditions namelist'
                stop
            endif
            read(unit, nml = integration, iostat = ierror)
            if(ierror /= 0) then
                print*, 'Error reading integration namelist'
                stop
            endif
            read(unit, nml = output, iostat = ierror)
            if(ierror /= 0) then
                print*, 'Error reading output namelist'
                stop
            endif
            close(unit)
        else
            print*, 'Argument, ', trim(namelist_file)
            print*, 'does not exist. Ending program'
            stop
        endif
    elseif(n_arguments /= 0) then
        print*, 'Incorrect number of arguments'
        print*, 'The program takes either 0 or 1 arguments'
        print*, 'See documentation on README.md for details'
        stop
    endif
    
end subroutine set_parameters

subroutine solve_runge_kutta(t_i, r_i, t_f, n_points, t, r)
    implicit none
    real(dp), intent(in) :: t_i, r_i(:), t_f
    integer, intent(in) :: n_points
    real(dp), intent(out), allocatable :: t(:), r(:, :)
    integer :: n_variables, i
    real(dp) :: h
    real(dp), allocatable :: k1(:), k2(:), r_sol(:), t_sol

    n_variables = size(r_i)

    allocate(t(n_points), r(n_variables, n_points))
    allocate(k1(n_variables), k2(n_variables), r_sol(n_variables))

    h = (t_f - t_i)/n
    r_sol = r_i
    t_sol = t_i
    do i=1,n
        k1 = h*func(r_sol, t_sol)
        k2 = h*func(r_sol + 0.5_dp*k1, t_sol + 0.5_dp*h)
        r_sol = r_sol + k2
        t_sol = t_sol + h
        t(i) = t_sol
        r(:, i) = r_sol
    enddo

end subroutine solve_runge_kutta

subroutine write_solution(fname, t_i, r_i, t, r)
    implicit none
    character(len=*), intent(in) :: fname
    real(dp), intent(in) :: t_i, r_i(:), t(:), r(:,:)

    integer :: n, i, unit

    n = size(t)

    open(newunit = unit, file = trim(fname))
    write(unit,'(3f25.8)') t_i, r_i
    do i=1,n
        write(unit,'(3f25.8)') t(i), r(:, i)
    enddo
    close(unit)
    
end subroutine write_solution

function func(r, t) result(f)
    implicit none
    real(dp), intent(in) :: r(:), t
    real(dp), allocatable :: f(:)
    allocate(f(1:size(r)))
    f(1) = alpha*r(1) - beta*r(1)*r(2)
    f(2) = gamma*r(1)*r(2) - delta*r(2)
end function func

end program odes_example
