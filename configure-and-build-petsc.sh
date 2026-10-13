SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
git clone -b v3.24.2 https://github.com/petsc/petsc

ENABLE_CUDA=1
ENABLE_OPENMP=0
if [ "${DEVICE_ARCH}" = "NATIVE" ]; then
  echo "BUILDING PETSC WITH NATIVE CPU ARCH"
  ENABLE_CUDA=0
  # the NATIVE Kokkos uses the OpenMP backend, so its headers require OpenMP
  ENABLE_OPENMP=1
fi

cd petsc
./configure --with-cc=mpicc --with-cxx=mpicxx --with-fc=mpifort \
	--prefix=$BUILD_DIR/${DEVICE_ARCH}/petsc/install \
	--PETSC_ARCH=arch-linux-c-debug-${DEVICE_ARCH} \
	--with-blaslapack-dir=$NETLIB_LAPACK_RHEL9_ROOT \
	--with-scalapack-dir=$NETLIB_SCALAPACK_RHEL9_ROOT \
	--with-kokkos-dir=$BUILD_DIR/${DEVICE_ARCH}/kokkos/install/ \
	--with-kokkos-kernels-dir=$BUILD_DIR/${DEVICE_ARCH}/kokkos-kernels/install \
	--with-cuda=${ENABLE_CUDA} \
	--with-openmp=${ENABLE_OPENMP} \
	--with-shared-libs=1

make PETSC_DIR=${SOURCE_DIR}/petsc PETSC_ARCH=arch-linux-c-debug-${DEVICE_ARCH} all
make PETSC_DIR=${SOURCE_DIR}/petsc PETSC_ARCH=arch-linux-c-debug-${DEVICE_ARCH} install
make PETSC_DIR=$BUILD_DIR/${DEVICE_ARCH}/petsc/install PETSC_ARCH="" check

cd $CURDIR
