#!/bin/bash
# usage: ./build.sh build_type test prefix
# example: ./build.sh Release|Debug ON|OFF $CONDA_PREFIX

build_type="Release"
if [ ! -z $1 ]; then
  build_type=$1
fi

run_test="ON"
if [ ! -z $2 ]; then
  run_test=$2
fi

INSTALL_PREFIX=$CONDA_PREFIX
if [ ! -z $3 ]; then
   INSTALL_PREFIX=$3
fi

mkdir -p build
cd build

cmake .. -DBUILD_TESTING=$run_test -DCMAKE_BUILD_TYPE=$build_type -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}

if [ "$run_test" == "ON" ]; then
  echo "make -j all && make -j install && ctest"
  # TODO percy alex c.gonzales
  #make -j all && make -j install && ctest
else
  echo "make -j install"
  make -j install
fi
