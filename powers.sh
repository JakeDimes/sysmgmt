#!/bin/bash

# NVIDIA
vendors=("0x10de")

state="power/runtime_status"
control="power/control"

arg_a=false

while getopts ":a" options; 
do
    case $options in
        a) arg_a=true ;;
        \?) echo "Invalid Option -$OPTARG" >&2 
            exit 1
            ;;
    esac
done

for i in /sys/bus/pci/devices/*;
do
    if $arg_a && [[ ${vendors[@]} -ne $(cat $i/vendor) ]]; then
        continue
    fi
    echo "$i ($(cat $i/vendor):$(cat $i/device)): $(cat $i/$control) $(cat $i/$state)";
done
