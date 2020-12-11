#!/usr/bin/env ruby

$idxs = [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]
def around(input, i, j)
    $idxs.reject { |i1, j1|
        i1 < -i || j1 < -j || i1 >= input.size-i || j1 >= input[i].size-j
    }.map { |i1, j1|
        input[i+i1][j+j1]
    }
end

def around_any(input, i, j)
    $idxs.reject { |i1, j1|
        i1 < -i || j1 < -j || i1 >= input.size-i || j1 >= input[i].size-j
    }.map { |i1, j1|
        factor = 1
        cur = '.'
        loop do
            ni = i + (i1 * factor)
            nj = j + (j1 * factor)
            break unless ni >= 0 && nj >= 0 && ni < input.size && nj < input[i].size
            cur = input[ni][nj]
            break if cur != '.'
            factor += 1
        end
        cur
    }
end

def mutate_map(input, ocupancy, &adj_block)
    input = input.map(&:dup)
    prev_input = nil
    while prev_input != input do
        prev_input = input.map(&:dup)
        input.each_with_index do |row, i|
            row.each_with_index do |seat, j|
                adj = yield(prev_input, i, j)
                if seat == 'L' && adj.count('#') == 0
                    input[i][j] = '#'
                elsif seat == '#' && adj.count('#') >= ocupancy
                    input[i][j] = 'L'
                end
            end
        end
    end
    input.map(&:join).join.count('#')
end

input = File.open('input').readlines.map(&:chomp).map(&:chars)

puts mutate_map(input, 4, &method(:around))
puts mutate_map(input, 5, &method(:around_any))
