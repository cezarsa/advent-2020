#!/usr/bin/env ruby

require 'matrix'

input = File.open('input').readlines.map(&:chomp).map{|x| [x[0], x[1..-1].to_i] }

pos = Vector[0, 0]
dirs = [Vector[1, 0], Vector[0,-1], Vector[-1, 0], Vector[0, 1]]
dir = 0
input.each { |op, val|
    case op
    when 'F'
        pos += dirs[dir] * val
    when 'L'
        dir = (dir - (val/90)) % dirs.size
    when 'R'
        dir = (dir + (val/90)) % dirs.size
    when 'N'
        pos += Vector[0, val]
    when 'S'
        pos -= Vector[0, val]
    when 'E'
        pos += Vector[val, 0]
    when 'W'
        pos -= Vector[val, 0]
    end
}
puts pos.map(&:abs).sum