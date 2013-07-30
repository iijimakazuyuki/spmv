#!/bin/sh
readonly MATRIX="10k.dat"
readonly OUTPUT="test.out"
readonly WORK_PREF="10k"

NP=4
NL=10

if [ $# -ge 2 ] ; then
	NP=$1
	NL=$2
fi

echo 3 100000 | ../../matgen/matgen.exe >$MATRIX
echo $NP ${WORK_PREF} | cat - $MATRIX | ./part_1d.exe

for i in `seq 2 $NL` ; do
	echo $i >>$OUTPUT
	echo ${WORK_PREF} $i | mpirun -np $NP ./mpi_spmv_test.exe >>$OUTPUT
done
