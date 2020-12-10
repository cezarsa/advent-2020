#!/usr/bin/env ruby

def part1(input)
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

def traverse_dynamic(graph, node, wanted, level=0, memo={})
    return 1 if node == wanted
    key = [node, level]
    if memo.has_key? key
        return memo[key]
    end
    paths = 0
    graph[node].each do |p|
        paths += traverse_dynamic(graph, p, wanted, level+1, memo)
    end
    memo[key] = paths
    return paths
end

def part2(input)
    graph = {}
    (input.size - 1).times {|i| graph[i] = [i+1] }
    input[0..-3].each_with_index do |v1, i1|
        input[i1+2..-1].each_with_index do |v2, i2|
            break if v2 - v1 > 3
            graph[i1] << i2+i1+2
        end
    end

    traverse_dynamic(graph, 0, input.size-1)
end


input = File.open('input').readlines.map(&:to_i).sort

puts part1 input
puts part2 input.push(input[-1]+3).insert(0, 0)