VPATH=../utilfort:../spmat
.SUFFIXES:
.SUFFIXES: .f90 .o
.PHONY: clean
FC=gfortran
FCFLAG=-fopenmp

OBJECT =\
	array.o\
	matcrs.o\
	std_spmv_test.o

TARGET = std_spmv_test.exe

$(TARGET): $(OBJECT)
	$(FC) -o $@ $(OBJECT) $(FCFLAG)

.f.o:
	$(FC) -c $< $(FCFLAG)

.f90.o:
	$(FC) -c $< $(FCFLAG)

clean:
	rm -f *.exe *.o *.mod *~
