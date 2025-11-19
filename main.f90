program main
  ! Declare variables

  implicit none
  real(8) , allocatable :: H_mat(:,:), S_mat(:,:), C_0(:,:), C(:,:), eps(:), H_mat_t(:,:), C_0_t(:,:), W(:), work(:)
  integer :: N, i, j, k, lwork, info
  character :: JOBZ, RANGE, UPLO







  

  ! Initialize variables

  N = 5 ! matrix dimension

  allocate(H_mat(N,N))
  allocate(H_mat_t(N,N))
  allocate(S_mat(N,N))
  allocate(C_0(N,N))
  allocate(C_0_t(N,N))
  allocate(C(N,N))
  allocate(eps(N))


  write(*,*)"--- 1. STARTING THE HAMILTONIAN SECTION ---"

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

  write(*,*)
  write(*,*)"--- 2. STARTING THE OVERLAP SECTION ---"

  call random_number(C_0)

  write(*,*)"Original C_0"

  do i = 1,N
    write(*,*)C_0(i,:)
  end do

  do i = 1, N
    do j = 1, N
      C_0(i, j) = 0.5 * (C_0(i, j) + C_0(j, i))
    end do
!     Add a scalar to diagonal for positive definiteness
    C_0(i, i) = C_0(i, i) + 5.0
  end do

  write(*,*)"Symmetrized C_0"

  do i = 1,N
    write(*,*)C_0(i,:)
  end do

  ! transpose the matrix
  do i = 1,N
    do j = 1,n
      C_0_t(j,i) = C_0(i,j)
    end do
  end do

  write(*,*)"Transposed C_0"

  do i = 1,N
    write(*,*)C_0_t(i,:)
  end do

  ! Overlap matrix as the product C_0 C_0^T

  do i = 1,N
    do j = 1,N
    S_mat(i,j) = 0
      do k = 1,N
      S_mat(i,j) = S_mat(i,j) + C_0(i,k)*C_0_t(k,j)
      end do
    end do
  end do

  write(*,*)"Overlap matrix"

  do i = 1,N
    write(*,*)S_mat(i,:)
  end do

  ! to check that overlap is correct, we have to diagonalize and check all the eigenvalues are positive

  JOBZ  = 'V'
  RANGE = 'A'
  UPLO  = 'U'
  lwork = 3*N-1

  allocate(W(N))
  allocate(work(lwork))

  call DSYEV(JOBZ, UPLO, N, S_mat, N, W, work, lwork, info)

  if (info .eq. 0) then
    write(*,*) 'INFO = ',info,'----> Successful run'
    write(*,*) W
  end if


end program main
