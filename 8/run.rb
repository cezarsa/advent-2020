#!/usr/bin/env ruby

prog = File.open('input').readlines.map(&:split).map{|x| [x[0], x[1].to_i]}

def run(prog)
    visited = {}
    trace = []
    cir = 0
    acc = 0
    while true do
        return acc, nil if cir == prog.size 
        return acc, trace if visited[cir]
        trace << cir
        ins = prog[cir]
        pcir = cir
        visited[cir] = true
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
end

acc, trace = run prog
puts acc

trace.reverse.each do |ir|
    try_prog = prog.clone.map(&:clone)
    ins = try_prog[ir]
    case ins[0]
    when 'nop'
        ins[0] = 'jmp'
    when 'jmp'
        ins[0] = 'nop'
    else
        next
    end
    acc, trace = run try_prog
    unless trace
        puts acc
        break
    end
end
