#!/usr/bin/env ruby

def part1()
    lines = File.open('input').readlines.map(&:chomp)
    idx = 3
    trees = 0
    lines[1..-1].each do |line|
        if line[idx%line.length] == '#' then
            trees += 1
        end
        idx += 3
    end
    puts trees
end

def part2()
    lines = File.open('input').readlines.map(&:chomp)
    slopes = [[1,1], [3,1], [5,1], [7,1], [1,2]]
    trees = Array.new(slopes.length, 0)
    idx = Array.new(slopes.length, 0)

    lines[1..-1].each_with_index do |line, line_i|
        slopes.each_with_index do |s, i|
            next if (line_i + 1) % s[1] != 0
            idx[i] += s[0]

            if line[idx[i]%line.length] == '#' then
                trees[i] += 1
            end
        end
    end
    puts trees.reduce(:*)
end

part1
part2