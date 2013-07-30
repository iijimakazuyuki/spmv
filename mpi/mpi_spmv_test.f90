program mpi_spmv_test
	use mpi
	use omp_lib
	use matcrs_mod
	use mat_mpi
	use mat_mess_mod
	use spmv_mpi
	implicit none
	type(matcrs_part) :: Ap
	type(mat_mess) :: send, recv
	double precision, allocatable :: x(:)
	double precision :: st, et, sum
	integer, parameter :: TRIAL = 10
	integer :: i, j, k, s, rank, np, err
	character(len=16) :: fname, prefix
	integer, parameter :: FILE = 101
	
	call MPI_INIT(err)
	call MPI_COMM_RANK(MPI_COMM_WORLD, rank, err)
	call MPI_COMM_SIZE(MPI_COMM_WORLD, np, err)
	
	if(rank == 0) then 
		read *, prefix, s
	end if
	
	call MPI_BCAST(prefix, 16, MPI_CHARACTER, 0, MPI_COMM_WORLD, err)
	call MPI_BCAST(s, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, err)

	write(fname, '(a,i2.2,".dat")') trim(prefix), rank+1
	open(21, file=fname, status='old')
		Ap = read_file_matcrs_part_array(21)
		send = read_file_mat_mess(21)
		recv = read_file_mat_mess(21)
	close(21)
	
	allocate(x(Ap%mat%m))
	
	sum = 0
	
	do k=1, TRIAL
	
	x = 1
	
	st = OMP_GET_WTIME()
	
	do i=1, s-1
		call spmv(Ap%mat,x,send,recv)
	end do
	
	et = OMP_GET_WTIME()
	
	sum = sum + et - st
	
	end do
	
	if(rank == 0) print *, sum/TRIAL
	
	call MPI_FINALIZE(err)
end program