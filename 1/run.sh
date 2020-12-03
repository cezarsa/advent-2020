#!/bin/bash

numbers=($(cat input))

part1() {
    i=-1
    for n1 in ${numbers[@]}; do
        i=$(($i+1))
        for n2 in ${numbers[@]:$i}; do
            if [[ $(($n1+$n2)) == 2020 ]]; then
                echo $(($n1*$n2))
                return
            fi
        done
    done
}

part2() {
    i=-1
    iterations=0
    for n1 in ${numbers[@]}; do
        i=$(($i+1))
        j=-1
        for n2 in ${numbers[@]:$i}; do
            j=$(($j+1))
            k=$(($i+$j))
            for n3 in ${numbers[@]:$k}; do
                if [[ $(($n1+$n2+$n3)) == 2020 ]]; then
                    echo $(($n1*$n2*$n3))
                    return
                fi
            done
        done
    done
}

part1
part2