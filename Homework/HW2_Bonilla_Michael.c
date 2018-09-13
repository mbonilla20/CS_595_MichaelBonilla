#include <stdio.h>
#include "mpi.h"

int main(int argc, char *argv[])
{
    int rank;
    int size;
    int i;
    int rank0;

    MPI_Init(0, 0);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    if (rank==0){
        rank0=rank;
        for(i=size-1; i >0; i--)
            {
             	MPI_Recv(&rank, 1, MPI_INT, i, 0,
                MPI_COMM_WORLD, MPI_STATUS_IGNORE);
				printf("Hello world from process %d of %d\n", rank, size);
            }
				printf("Hello world from process %d of %d\n", rank0, size);
    } else {
            MPI_Send(&rank, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
           }
    MPI_Finalize();
    return 0;
}

