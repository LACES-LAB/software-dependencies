DIR=$PWD

source $DIR/loads-rhel9.sh



SOURCE_DIR="${SOURCE_DIR:-/users/mersoj2/laces-software/sources}"
BUILD_DIR="${BUILD_DIR:-/users/mersoj2/laces-software/build/}"
DEVICE_ARCH="${DEVICE_ARCH:-ADA89}"

SCRIPT_DIR=$(realpath $(dirname "$0"))

mkdir $SOURCE_DIR
cd $SOURCE_DIR


# dependencies for PCMS
source $DIR/configure-and-build-catch2.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-kokkos.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-kokkos-kernels.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-pybind11.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-seacas.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-omega-h.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-perfstubs.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-adios2.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-redev.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-meshFields.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-petsc.sh $SOURCE_DIR $BUILD_DIR

## additional dependencies for mumfim
source $DIR/configure-and-build-yaml-cpp.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-core.sh $SOURCE_DIR $BUILD_DIR $SCRIPT_DIR
source $DIR/configure-and-build-fmt.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-model-traits.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-las.sh $SOURCE_DIR $BUILD_DIR

# additional dependencies for pumi-pic
source $DIR/configure-and-build-engpar.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-cabana.sh $SOURCE_DIR $BUILD_DIR

cd $DIR
