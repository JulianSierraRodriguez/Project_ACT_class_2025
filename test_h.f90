program main
  ! Declare variables

  implicit none
  real(8) , allocatable :: H_mat(:,:),H_mat_t(:,:), S_mat(:,:), C_0(:,:), C(:,:), eps(:)
  integer :: N, i, j, k







  

  ! Initialize variables

  N = 5 ! matrix dimension

  allocate(H_mat(N,N))
  allocate(H_mat_t(N,N))
  allocate(S_mat(N,N))
  allocate(C_0(N,N))
  allocate(C(N,N))
  allocate(eps(N))


  ! Write Hammiltonian - must be hermitic
  ! Equal the adjoint - use only real numbers
  ! Equal the transpose  -symmetric
 
  call random_number(H_mat) ! Fill with random numbers

  ! Symmetrize the matrix 
  do i = 1,N
    do j = 1, N
      H_mat(i, j) = H_mat(j,i)
    end do
  end do

  write(*,*)"Hammiltonian H"

  do i = 1,N
    write(*,*)H_mat(i,:)
  end do


  ! Check it is symmetric: calculate the transpose
  do i = 1,N
    do j = 1,N
      H_mat_t(j,i) = H_mat(i,j) 
    end do
  end do

  write(*,*)"Transposed of Hammiltonian H_t"

  do i = 1,N
    write(*,*)H_mat_t(i,:)
  end do


end program main
