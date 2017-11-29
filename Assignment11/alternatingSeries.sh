#!/bin/sh
#SBATCH --account=edu      
#SBATCH --job-name=AlternatingSeries    
#SBATCH -N 4
#SBATCH --exclusive
#SBATCH --time=5:00   

source activate geo_scipy

mpirun -n 1 python alternatingSeriesMPI.py
mpirun -n 2 python alternatingSeriesMPI.py
mpirun -n 3 python alternatingSeriesMPI.py
mpirun -n 6 python alternatingSeriesMPI.py
mpirun -n 12 python alternatingSeriesMPI.py
mpirun -n 24 python alternatingSeriesMPI.py
mpirun -n 48 python alternatingSeriesMPI.py
mpirun -n 96 python alternatingSeriesMPI.py
