# LACES software dependencies

Scripts that build PCMS, PUMI-PIC, MuMFiM, and their dependencies on the
SCOREC RHEL9 machines, using the SCOREC system modules for the compiler, MPI,
CUDA, and other system libraries.

On other systems, build PCMS with Spack or use the container; see the
[PCMS README](https://github.com/SCOREC/pcms#build-instructions).

## Layout

| Script | Purpose |
|---|---|
| `loads-rhel9.sh` | Loads the modules every other script needs (gcc, mpich, CUDA, CMake, NetCDF, Python, ...) |
| `build-deps-rhel9.sh` | Builds all dependencies of PCMS, MuMFiM, and PUMI-PIC |
| `configure-and-build-<package>.sh` | Builds one dependency; called by `build-deps-rhel9.sh` |
| `build-pcms-rhel9.sh` | Builds PCMS against the dependencies |
| `build-pumi-pic-rhel9.sh`, `build-mumfim.sh`, `build-mfem.sh` | Build the other applications |

## Settings

The scripts read these environment variables:

| Variable | Meaning | Default |
|---|---|---|
| `SOURCE_DIR` | Where sources are cloned | `/users/mersoj2/laces-software/sources` |
| `BUILD_DIR` | Where packages are built and installed | `/users/mersoj2/laces-software/build/` |
| `DEPENDENCY_DIR` | Where the application scripts look for the dependencies (the `BUILD_DIR` used for `build-deps-rhel9.sh`) | `/users/mersoj2/laces-software/build/` |
| `DEVICE_ARCH` | Kokkos architecture, e.g. `ADA89` or `AMPERE80` for CUDA, or `NATIVE` for a CPU-only (OpenMP) build | `ADA89` |

Packages that depend on the device (Kokkos, Kokkos Kernels, Omega_h, redev,
MeshFields, PETSc, and the applications) are installed under
`$BUILD_DIR/$DEVICE_ARCH/<package>/install`; the rest under
`$BUILD_DIR/<package>/install`. One `BUILD_DIR` can therefore hold builds for
several architectures.

## Building PCMS

Prebuilt dependencies are available in `/users/mersoj2/laces-software/build`,
which is the default `DEPENDENCY_DIR`. Use them unless you need to change a
dependency.

1. Clone this repository:
   ```console
   $ git clone git@github.com:laces-lab/software-dependencies.git
   $ cd software-dependencies
   ```
2. Choose where your PCMS source and build go:
   ```console
   $ export SOURCE_DIR=$HOME/laces-software/sources
   $ export BUILD_DIR=$HOME/laces-software/build
   $ mkdir -p $SOURCE_DIR $BUILD_DIR
   ```
3. Build PCMS:
   ```console
   $ bash build-pcms-rhel9.sh
   ```
   PCMS is installed in `$BUILD_DIR/$DEVICE_ARCH/pcms/install`.

To use the build, load the same modules first: `source loads-rhel9.sh`.

### Building the dependencies yourself

To build your own dependencies, for example to change one of them, run
`build-deps-rhel9.sh` from this directory (it finds `loads-rhel9.sh` and the
other scripts there), then point PCMS at them:

```console
$ bash build-deps-rhel9.sh
$ DEPENDENCY_DIR=$BUILD_DIR bash build-pcms-rhel9.sh
```
