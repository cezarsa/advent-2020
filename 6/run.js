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

part1();
