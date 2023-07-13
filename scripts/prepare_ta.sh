#!/bin/bash

while getopts t:g:b:f:h flag
do
    case "${flag}" in
        t)
            TOP_DIR=${OPTARG}
            ;;
        g)
            GEN=${OPTARG}
            ;;
        b)
            TA_DIR=${OPTARG}
        ;;
        f)
            FROM=${OPTARG}
        ;;
        h)
            echo "options:"
            echo " -t - application source top dir"
            echo " -f - ta binary source dir"
            echo " -b - directory with ta binaries in app src"
            echo " -g - directory with generated files"
            exit
            ;;
    esac
done
SRC_DIR=$1
TA_SRC_DIR=$2

GEN_DIR=$TOP_DIR/$GEN
TA_DIR=$TOP_DIR/$TA_DIR

[ -d $TA_DIR ] || mkdir $TA_DIR
[ -d $GEN_DIR ] || mkdir $GEN_DIR

rm -rf $TA_DIR/*

cp $FROM/*.ta $TA_DIR

$TOP_DIR/scripts/gen_ta_src.py -s $TA_DIR -o $GEN_DIR/ta_table
