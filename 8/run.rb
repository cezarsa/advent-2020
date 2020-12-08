#!/usr/bin/env ruby

$prog = File.open('input').readlines.map(&:split).map{|x| [x[0], x[1].to_i]}

def part1
    cir = 0
    acc = 0
    while true do
        ins = $prog[cir]
        break if ins[2]
        ins[2] = true
        case ins[0]
        when 'jmp'
            cir += ins[1]
        when 'acc'
            acc += ins[1]
            cir += 1
        else
            cir += 1
        end
    end

    puts acc
end

part1