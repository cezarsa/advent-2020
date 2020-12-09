#!/usr/bin/env ruby

input = File.open('input').readlines.map(&:to_i)

input[25..-1].each_with_index do |n, i|
    puts n unless input[i..i+24].combination(2).map{|x|x.reduce(:+)}.include?(n)
end
