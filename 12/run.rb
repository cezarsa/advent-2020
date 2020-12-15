#!/usr/bin/env ruby

require 'matrix'

def part1(input)
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
end

def rmatrix(degrees)
    rad = (degrees * Math::PI) / 180 
    Matrix[[Math.cos(rad), -Math.sin(rad)], [Math.sin(rad), Math.cos(rad)]]
end

def rotate(degrees, point)
    (rmatrix(degrees) * point.to_matrix).column_vectors[0]
end

def part2(input)
    pos = Vector[0, 0]
    waypoint = Vector[10, 1]
    input.each { |op, val|
        case op
        when 'F'
            pos += waypoint * val
        when 'L'
            waypoint = rotate(val, waypoint)
        when 'R'
            waypoint = rotate(-val, waypoint)
        when 'N'
            waypoint += Vector[0, val]
        when 'S'
            waypoint -= Vector[0, val]
        when 'E'
            waypoint += Vector[val, 0]
        when 'W'
            waypoint -= Vector[val, 0]
        end
    }
    puts pos.map(&:abs).sum.round
end

input = File.open('input').readlines.map(&:chomp).map{|x| [x[0], x[1..-1].to_i] }
part1 input
part2 input