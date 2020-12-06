#!/usr/bin/env node

const readline = require('readline');
const fs = require('fs');


async function part1() {
    const rl = readline.createInterface({
        input: fs.createReadStream('input'),
    });

    var group = {}, count = 0;
    for await (const line of rl) {
        if (line == '') {
            count += Object.keys(group).length
            group = {}
            continue
        }
        for (var c of line) {
            group[c] = true
        }
    }
    count += Object.keys(group).length
    console.log(count)
}

function intersection(sets) {
    return sets.reduce((acc, v) => new Set([...acc].filter(x => v.has(x))));
}

async function part2() {
    const rl = readline.createInterface({
        input: fs.createReadStream('input'),
    });

    var sets = [], count = 0;
    for await (const line of rl) {
        if (line == '') {
            count += intersection(sets).size
            sets = []
            continue
        }
        let s = new Set()
        for (var c of line) {
            s.add(c)
        }
        sets.push(s)
    }
    count += intersection(sets).size
    console.log(count)
}

part1();
part2();
