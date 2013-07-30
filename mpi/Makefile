VPATH=../utilfort:../spmat:../matmpi
.SUFFIXES:
.SUFFIXES: .f90 .o
.PHONY: clean
FC=mpif90
FCFLAG=-fopenmp

OBJECT =\
	array.o\
	matcrs.o\
	mat_mess.o\
	mat_mpi.o\
	spmv_mpi.o\
	mpi_spmv_test.o

TARGET = mpi_spmv_test.exe

$(TARGET): $(OBJECT)
	$(FC) -o $@ $(OBJECT) $(FCFLAG)

.f.o:
	$(FC) -c $< $(FCFLAG)

.f90.o:
	$(FC) -c $< $(FCFLAG)

clean:
	rm -f *.exe *.o *.mod *~
