#!/bin/bash

module purge
module use /opt/scorec/spack/rhel9/v0201_4/lmod/linux-rhel9-x86_64/Core/
module load gcc/12.3.0-iil3lno mpich/4.1.1-xpoyz4t cuda/12.1.1-zxa4msk
module load fftw/3.3.10-qqvl57a
module load cmake/3.26.3-xxgzxlv
# netcdf-c (and its parallel hdf5) for SEACAS Exodus
module load netcdf-c/4.9.2-2ilqxr3

# additional loads for mumfim
module load simmetrix-simmodsuite/2025.0-250108dev-llxq6sk
# note we need a specific version of pumi with a patch, so we must build ourselves (i.e., no modules)

#module load openblas/0.3.23-wqm7iud
module load netlib-lapack/3.11.0-b22mgwg #netlib-lapack includes blas
module load netlib-scalapack/2.2.0-fzd4jvl

# python
module load python/3.10.10-fy3aixq
# we do not use pybind11 module because this conflicts with nvcc
# see: https://github.com/pybind/pybind11/pull/4893
# therefore, we build a newer version of py-pybind11
#module load py-pybind11/2.10.1-gnflqne

export NVCC_WRAPPER_DEFAULT_COMPILER=`which mpicxx`
