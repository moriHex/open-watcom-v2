#!/bin/sh
#
# Script to build the Open Watcom tools on Travis
# using the host platform's native C/C++ compiler.
#
# Expects 
#   - POSIX tools
#   - correct setup for all OW build environment variables
#

bootutil_proc()
{
    #
    # build new verison of wmake for host system
    #
    cd $OWSRCDIR/wmake
    mkdir $OWOBJDIR
    cd $OWOBJDIR
    rm -f $OWBINDIR/wmake
    case `uname` in
        Darwin)
            make -f ../posmake clean
            make -f ../posmake TARGETDEF=-D__OSX__
            ;;
        *)
            make -f ../posmake clean
            make -f ../posmake TARGETDEF=-D__LINUX__
            ;;
    esac
    RC=$?
    if [ $RC -eq 0 ]; then
        #
        # build new verison of builder for host system
        #
        cd $OWSRCDIR/builder
        mkdir $OWOBJDIR
        cd $OWOBJDIR
        rm -f $OWBINDIR/builder
        $OWBINDIR/wmake -f ../binmake clean
        $OWBINDIR/wmake -f ../binmake bootstrap=1 builder.exe
        RC=$?
    fi
}

build_proc()
{
    case "$OWTRAVISJOB" in
        "BOOTSTRAP")
            bootutil_proc
            if [ $RC -eq 0 ]; then
                cd $OWSRCDIR
                if [ "$TRAVIS_EVENT_TYPE" = "pull_request" ]; then
                    builder boot
                else
                    builder -q boot
                fi
                RC=$?
            fi
            ;;
        "BUILD")
            cd $OWSRCDIR
            if [ "$TRAVIS_EVENT_TYPE" = "pull_request" ]; then
                builder build
                RC=$?
            else
                builder -q build
                RC=$?
                if [ $RC -eq 0 ]; then
                    export OWRELROOT=$OWROOT/test
                    builder -q cprel
                fi
            fi
            ;;
        "BUILD1")
            cd $OWSRCDIR
            if [ "$TRAVIS_EVENT_TYPE" = "pull_request" ]; then
                builder build1
                RC=$?
            else
                builder -q build1
                RC=$?
                if [ $RC -eq 0 ]; then
                    export OWRELROOT=$OWROOT/test
                    builder -q cprel1
                fi
            fi
            if [ $RC -eq 0 ]; then
                if [ "$OWTRAVIS_DEBUG" = "1" ]; then
                    echo "copy build 1 to cache"
                fi
                cp -Rf $OWSRCDIR/* $OWROOT/build1
            fi
            ;;
        "BUILD2")
            if [ "$OWTRAVIS_DEBUG" = "1" ]; then
                echo "load build 1 from cache"
            fi
            cp -Rn $OWROOT/build1/* $OWSRCDIR
            cd $OWSRCDIR
            if [ "$TRAVIS_EVENT_TYPE" = "pull_request" ]; then
                builder build2
                RC=$?
            else
                builder -q build2
                RC=$?
                if [ $RC -eq 0 ]; then
                    export OWRELROOT=$OWROOT/test
                    builder -q cprel2
                fi
            fi
            ;;
        *)
            return 0
            ;;
    esac
    cd $OWROOT
    return $RC
}

build_proc $*
