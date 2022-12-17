##!/bin/bash
set -e


build()
{
    if [ ! -x "build" ]; then
        echo "create 'build' folder"
        mkdir -p build
    fi
    
    if [ ! -x "out" ]; then
        echo "create 'out' folder"
        mkdir -p out
    fi

    echo "enter 'build' folder"
    cd build

    echo "generate makefile with flags and target toolchain"
    cmake .. -DCMAKE_TOOLCHAIN_FILE=toolchain.camke.gcc

    echo "build (ie 'make')"
    cmake --build .
}


builduttest()
{
    if [ ! -x "build" ]; then
        echo "create 'build' folder"
        mkdir -p build
    fi
    
    if [ ! -x "out" ]; then
        echo "create 'out' folder"
        mkdir -p out
    fi

    echo "enter 'build' folder"
    cd build

    echo "generate makefile with flags and target toolchain"
    cmake .. -DCMAKE_TOOLCHAIN_FILE=toolchain.camke.gcc -DUT_TEST=ON

    echo "build (ie 'make')"
    cmake --build .
}


clean()
{
    if [ -x "build" ]; then
        echo "remove 'build' folder"
        rm -rf build
    fi
    
    if [ -x "out" ]; then
        echo "remove 'out' folder"
        rm -rf out
    fi
}


case "$1" in
    clean)
        echo "clean:"
        clean
        ;;
    ut)
        echo "ut:"
        builduttest
        ;;
    *)
        echo "build:"
        build
        ;;
esac