program main
  ! Declare variables

  implicit none
  real(8) , allocatable :: S_mat(:,:), C_0(:,:), C_0_transp(:,:), W(:), work(:)
  integer :: N, i, j, k, lwork, info
  character :: JOBZ, RANGE, UPLO







  

  ! Initialize variables

  N = 5 ! matrix dimension

  allocate(S_mat(N,N))
  allocate(C_0(N,N))
  allocate(C_0_transp(N,N))

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
      C_0_transp(j,i) = C_0(i,j)
    end do
  end do

  write(*,*)"Transposed C_0"

  do i = 1,N
    write(*,*)C_0_transp(i,:)
  end do

  ! Overlap matrix as the product C_0 C_0^T

  do i = 1,N
    do j = 1,N
    S_mat(i,j) = 0
      do k = 1,N
      S_mat(i,j) = S_mat(i,j) + C_0(i,k)*C_0_transp(k,j)
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
! dsyev