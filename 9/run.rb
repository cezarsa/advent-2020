#!/usr/bin/env ruby

input = File.open('input').readlines.map(&:to_i)

def part1(input)
    input[25..-1].each_with_index do |n, i|
        return n unless input[i..i+24].combination(2).map{|x|x.sum}.include?(n)
    end
end

def part2(input, n)
    input.each_with_index do |n1, i|
        sum = n1
        input[i+1..-1].each_with_index do |n2, j|
            sum += n2
            return input[i...i+j+2] if sum == n
        end
    end
end

n = part1 input
puts n
r = part2 input, n
puts r.min + r.max
