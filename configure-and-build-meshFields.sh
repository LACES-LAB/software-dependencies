SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
export NVCC_WRAPPER_DEFAULT_COMPILER=`which mpicxx`

git clone git@github.com:SCOREC/meshFields.git

cd meshFields
git checkout 5ff3e052ff75d59e1c5d71dd17faad0dbd9720f4
cd ..

cmake -S $SOURCE_DIR/meshFields -B $BUILD_DIR/${DEVICE_ARCH}/meshFields \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/${DEVICE_ARCH}/meshFields/install \
  -DOmega_h_DIR=$BUILD_DIR/${DEVICE_ARCH}/omega_h/install/lib64/cmake/Omega_h/ \
  -DKokkos_DIR=$BUILD_DIR/${DEVICE_ARCH}/kokkos/install/lib64/cmake/Kokkos/ \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON

cmake --build $BUILD_DIR/${DEVICE_ARCH}/meshFields/ -j8 --target install
cd $CURDIR
