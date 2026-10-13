SOURCE_DIR=$1
BUILD_DIR=$2

# Builds only the SEACAS Exodus library (needed for Omega_h Exodus I/O).
# Requires the netcdf-c module from loads-rhel9.sh.
CURDIR=$PWD
cd $SOURCE_DIR

git clone -b v2025-10-14 git@github.com:sandialabs/seacas.git

cmake -S $SOURCE_DIR/seacas -B $BUILD_DIR/seacas \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/seacas/install \
  -DCMAKE_CXX_COMPILER=`which mpicxx` \
  -DCMAKE_C_COMPILER=`which mpicc` \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DSeacas_ENABLE_ALL_PACKAGES=OFF \
  -DSeacas_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \
  -DSeacas_ENABLE_SECONDARY_TESTED_CODE=OFF \
  -DSeacas_ENABLE_SEACASExodus=ON \
  -DSeacas_ENABLE_Fortran=OFF \
  -DSeacas_ENABLE_TESTS=OFF \
  -DTPL_ENABLE_MPI=ON \
  -DTPL_ENABLE_Netcdf=ON \
  -DNetCDF_ROOT=$NETCDF_C_RHEL9_ROOT \
  -DTPL_Netcdf_LIBRARIES=$NETCDF_C_RHEL9_ROOT/lib/libnetcdf.so \
  "-DTPL_Netcdf_INCLUDE_DIRS=$NETCDF_C_RHEL9_ROOT/include;$HDF5_RHEL9_ROOT/include" \
  -DTPL_ENABLE_HDF5=ON \
  -DHDF5_ROOT=$HDF5_RHEL9_ROOT \
  -DHDF5_NO_SYSTEM_PATHS=ON \
  "-DTPL_HDF5_LIBRARIES=$HDF5_RHEL9_ROOT/lib/libhdf5_hl.so;$HDF5_RHEL9_ROOT/lib/libhdf5.so" \
  -DTPL_HDF5_INCLUDE_DIRS=$HDF5_RHEL9_ROOT/include \
  -DTPL_ENABLE_Pnetcdf=OFF \
  -DTPL_ENABLE_Pthread=OFF \
  -DTPL_ENABLE_X11=OFF

cmake --build $BUILD_DIR/seacas/ -j8 --target install
cd $CURDIR
