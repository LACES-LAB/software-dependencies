source /users/mersoj2/laces-software/scripts/loads-rhel9.sh
# UPDATE TO YOUR OWN DIRECTORY
SOURCE_DIR="${SOURCE_DIR:-/users/mersoj2/laces-software/sources}"
# UPDATE TO YOUR OWN DIRECTORY
BUILD_DIR="${BUILD_DIR:-/users/mersoj2/laces-software/build/}"

# LEAVE THESE ALONE (for now)
DEVICE_ARCH="${DEVICE_ARCH:-ADA89}"
DEPENDENCY_DIR="${DEPENDENCY_DIR:-/users/mersoj2/laces-software/build/}"


CURDIR=$PWD
cd $SOURCE_DIR

git clone git@github.com:SCOREC/pcms.git
git clone git@github.com:jacobmerson/pcms_testcases.git

export NVCC_WRAPPER_DEFAULT_COMPILER=`which mpicxx`

cmake -S $SOURCE_DIR/pcms -B $BUILD_DIR/${DEVICE_ARCH}/pcms \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/${DEVICE_ARCH}/pcms/install \
  -DCMAKE_CXX_COMPILER=`which mpicxx` \
  -DCMAKE_C_COMPILER=`which mpicc` \
  -DCMAKE_Fortran_COMPILER=`which mpifort`\
  -DCMAKE_BUILD_TYPE=Release \
  -DCatch2_DIR=$DEPENDENCY_DIR/Catch2/install/lib64/cmake/Catch2/ \
  -Dmeshfields_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/meshFields/install/lib64/cmake/meshfields \
  -DOmega_h_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/omega_h/install/lib64/cmake/Omega_h/ \
  -Dredev_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/redev/install/lib64/cmake/redev/ \
  -Dflcl_DIR=$DEPENDENCY_DIR/flcl/install/lib64/cmake/flcl/ \
  -DPCMS_TEST_DATA_DIR=$SOURCE_DIR/pcms_testcases \
  -DMPIEXEC_EXECUTABLE=`which mpirun` \
  -DADIOS2_DIR=$DEPENDENCY_DIR/adios2/install/lib64/cmake/adios2/ \
  -Dperfstubs_DIR=$DEPENDENCY_DIR/perfstubs/install/lib/cmake/ \
  -DKokkos_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/kokkos/install/lib64/cmake/Kokkos/ \
  -DKokkosKernels_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/kokkos-kernels/install/lib64/cmake/KokkosKernels/ \
  -DBUILD_TESTING=ON \
  -DPCMS_ENABLE_PETSC=ON \
  -DPETSC_ARCH="" \
  -DPCMS_ENABLE_PETSC=ON \
  -DPETSC_DIR=$BUILD_DIR/${DEVICE_ARCH}/petsc/install \
  -DPCMS_ENABLE_SPDLOG=OFF \
  -DPCMS_ENABLE_Python=ON \
  -Dpybind11_ROOT=$BUILD_DIR/pybind11/install

cmake --build $BUILD_DIR/${DEVICE_ARCH}/pcms/ -j8 --target install
cd $CURDIR
