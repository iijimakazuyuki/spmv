program std_spmv_test
	use omp_lib
	use matcrs_mod
	type(matcrs) :: a
	double precision :: st, et
	double precision, allocatable :: x(:)
	integer :: i, s = 99
	a = read_matcrs_array()
	allocate(x(a%n))
	x = 1
	st = omp_get_wtime()
	do i=1, s
		x = a*x
	end do
	et = omp_get_wtime()
	
	print *, 1, et-st
	
	print *, x
end program