program main
  ! Declare variables

  implicit none
  real(8) , allocatable :: S_mat(:,:), C_0(:,:)
  integer :: N, i, j, k







  

  ! Initialize variables

  N = 5 ! matrix dimension

  allocate(S_mat(N,N))
  allocate(C_0(N,N))

  call random_number(C_0)

  write(*,*)"Original C_0"

  do i = 1,N
    write(*,*)C_0(i,:)
  end do

  do i = 1, 5
    do j = 1, 5
      C_0(i, j) = 0.5 * (C_0(i, j) + C_0(j, i))
    end do
!     Add a scalar to diagonal for positive definiteness
    C_0(i, i) = C_0(i, i) + 5.0
  end do

  write(*,*)"Symmetrized C_0"

  do i = 1,N
    write(*,*)C_0(i,:)
  end do


end program main
