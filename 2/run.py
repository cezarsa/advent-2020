#!/usr/bin/env python

import re

with open("input") as f:
    lines = f.readlines()

line_regex = re.compile(r'(\d+)-(\d+) (\w): ([^\s]+)')


def part1():
    valid = 0
    for line in lines:
        groups = line_regex.match(line).groups()
        min_c = int(groups[0])
        max_c = int(groups[1])
        wanted = groups[2]
        passwd = groups[3]
        freq = 0
        for c in passwd:
            if c == wanted:
                freq += 1
        if freq >= min_c and freq <= max_c:
            valid += 1
    print(valid)


def part2():
    valid = 0
    for line in lines:
        groups = line_regex.match(line).groups()
        pos1 = int(groups[0])
        pos2 = int(groups[1])
        wanted = groups[2]
        passwd = groups[3]
        if len(passwd) < pos2:
            continue
        e1 = passwd[pos1-1] == wanted
        e2 = passwd[pos2-1] == wanted
        if e1 != e2:
            valid += 1
    print(valid)


part1()
part2()
