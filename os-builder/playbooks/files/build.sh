#!/bin/sh -eu

export MAKEOBJDIRPREFIX="${HOME}/obj"

echo "Build the sources"
cd "${HOME}/src" || return 1
make buildworld -j 8 -DNO_CLEAN
make buildkernel -j8 -DNO_CLEAN
