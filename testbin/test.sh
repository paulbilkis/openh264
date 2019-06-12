#!/bin/bash

if [ -z "$1" ]
then
    echo "No arch is specified. x86 is applied."
    ARCH=x86
    builddir="x86_build"
else
    ARCH=$1
fi


if [ -z "$2" ]
then
    echo "No emulator is specified. x86 is applied."
    ARCH=x86
    LOG=x86
    builddir="x86_build"
    emulator=""
else
    LOG=$2
fi

if [[ $ARCH = "x86" ]]
then
    builddir="x86_build"
    emulator=""
elif [[ $ARCH = "msa" ]]
then
    builddir="mips_build_msa"
elif [[ $ARCH = "ref" ]]
then
    builddir="mips_build_ref"
elif [[ $ARCH = "ref_commented" ]]
then
    builddir="mips_build_ref_commented"
elif [[ $ARCH = "msa_commented" ]]
then
    builddir="mips_build_msa_commented" 
fi

if [[ $LOG = "x86" ]]
then
    emulator=""
elif [[ $LOG = "no_log" ]]
then
    emulator="/home/bilkis/qemu/build/mips64el-linux-user/qemu-mips64el -cpu I6400"
elif [[ $LOG = "log" ]]
then
    emulator="/home/bilkis/qemu-mod/mips64el-linux-user/qemu-mips64el -cpu I6400"
fi

echo $builddir
echo $emulator

#$emulator ../$builddir/h264enc welsenc_vd_1d.cfg
#$emulator ../$builddir/h264enc welsenc_vd_rc.cfg
#$emulator ../$builddir/h264enc welsenc_arbitrary_res.cfg

#$emulator ../$builddir/h264enc welsenc_arbitrary_res.cfg

#$emulator ../$builddir/h264dec ../res/test_vd_1d.264 test_vd_1d.yuv
#$emulator ../$builddir/h264dec ../res/test_vd_rc.264 test_vd_rc.yuv
$emulator ../$builddir/h264dec Static.264 Static.yuv
