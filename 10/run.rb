#!/usr/bin/env ruby

input = File.open('input').readlines.map(&:to_i).sort

def part1 input
    prev = 0
    input.map { |x|
        d = x - prev
        prev = x
        d
    }.reduce([0, 0]) { |acc, v|
        acc[v/3] += 1
        acc
    }.tap{ |x| x[1] += 1 }.reduce(1, :*)
end

puts part1 input
