SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
export NVCC_WRAPPER_DEFAULT_COMPILER=`which mpicxx`

#git clone -b reducedThrust git@github.com:SCOREC/omega_h.git
git clone git@github.com:SCOREC/omega_h.git
cd omega_h
git checkout 8fc0a0bb3140e601cea86ebcbd2faecd30b410bf
cd ..

cmake -S $SOURCE_DIR/omega_h -B $BUILD_DIR/${DEVICE_ARCH}/omega_h \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/${DEVICE_ARCH}/omega_h/install \
  -DCMAKE_CXX_COMPILER=`which mpicxx` \
  -DCMAKE_C_COMPILER=`which mpicc` \
  -DOmega_h_USE_MPI=ON \
  -DOmega_h_USE_Kokkos=ON \
  -DBUILD_TESTING=ON \
  -DMPIEXEC_EXECUTABLE=`which mpirun` \
  -DBUILD_SHARED_LIBS=OFF \
  -DKokkos_DIR=$BUILD_DIR/${DEVICE_ARCH}/kokkos/install/lib64/cmake/Kokkos/ \
  -DCMAKE_VERBOSE_MAKEFILE=ON \
  -DBUILD_SHARED_LIBS=ON \
  -DOmega_h_USE_pybind11=on \
  -Dpybind11_ROOT=$BUILD_DIR/pybind11/install

cmake --build $BUILD_DIR/${DEVICE_ARCH}/omega_h/ -j8 --target install
cd $CURDIR
