from mpi4py import MPI
import numpy as np
from timeit import default_timer as timer


def alternating_harmonic_series(N,rank,size):
    val = 0.0
    num_step=int(N/size)
    for n in np.linspace(rank+1, N, num_step, dtype=int):
        val += (-1)**(n+1) / n
    return val

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

start = timer()
N     = 100000
value = alternating_harmonic_series(N,rank,size)

send_val = np.array(value,'d')
sum = np.array(0.0,'d')

comm.Reduce(send_val,sum,op=MPI.SUM,root=0)

stop  = timer()

if rank == 0:
    print(' Number of terms in series: ',N)
    print(' Ending value of series: ',sum)
    print(' Elapsed time: ',stop-start)
