program main
  ! Declare variables

  implicit none
  real(8) , allocatable :: H_mat(:,:), S_mat(:,:), C_0(:), C(:), eps(:)
  integer :: N, i, j, k







  

  ! Initialize variables

  N = 5 ! matrix dimension

  allocate(H_mat(N,N))
  allocate(S_mat(N,N))
  allocate(C_0(N))
  allocate(C(N))
  allocate(eps(N))

  do i = 1, N
    write(*,*) H_mat(i)
  end do


end program main
