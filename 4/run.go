package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
	"regexp"
	"strconv"
	"strings"
)

var required = map[string]func(string) bool{
	"byr": func(s string) bool {
		val, _ := strconv.Atoi(s)
		return val >= 1920 && val <= 2002
	},
	"iyr": func(s string) bool {
		val, _ := strconv.Atoi(s)
		return val >= 2010 && val <= 2020
	},
	"eyr": func(s string) bool {
		val, _ := strconv.Atoi(s)
		return val >= 2020 && val <= 2030
	},
	"hgt": func(s string) bool {
		if len(s) < 4 {
			return false
		}
		val, _ := strconv.Atoi(s[:len(s)-2])
		if strings.HasSuffix(s, "in") {
			return val >= 59 && val <= 76
		}
		if strings.HasSuffix(s, "cm") {
			return val >= 150 && val <= 193
		}
		return false
	},
	"hcl": func(s string) bool {
		valid, _ := regexp.MatchString(`^#[0-9a-f]{6}$`, s)
		return valid
	},
	"ecl": func(s string) bool {
		valid, _ := regexp.MatchString(`^amb|blu|brn|gry|grn|hzl|oth$`, s)
		return valid
	},
	"pid": func(s string) bool {
		valid, _ := regexp.MatchString(`^[0-9]{9}$`, s)
		return valid
	},
}

func main() {
	f, err := os.Open("input")
	if err != nil {
		panic(err)
	}
	part1(f)
	f.Seek(0, os.SEEK_SET)
	part2(f)
}

func part1(f io.Reader) {
	scanner := bufio.NewScanner(f)
	scanner.Split(scanDoubleLines)
	validCount := 0
passports:
	for scanner.Scan() {
		passport := scanner.Text()
		for token := range required {
			if !strings.Contains(passport, token+":") {
				continue passports
			}
		}
		validCount++
	}
	fmt.Println(validCount)
}

func part2(f io.Reader) {
	scanner := bufio.NewScanner(f)
	scanner.Split(scanDoubleLines)
	validCount := 0
passports:
	for scanner.Scan() {
		tokens := tokenize(scanner.Text())
		for token, validate := range required {
			if !validate(tokens[token]) {
				continue passports
			}
		}
		validCount++
	}
	fmt.Println(validCount)
}

var passportRegexp = regexp.MustCompile(`(\w{3}):(.+?)(\s|$)`)

func tokenize(passport string) map[string]string {
	result := map[string]string{}
	matches := passportRegexp.FindAllStringSubmatch(passport, -1)
	for _, entry := range matches {
		if len(entry) < 3 {
			continue
		}
		result[entry[1]] = entry[2]
	}
	return result
}

func scanDoubleLines(data []byte, atEOF bool) (int, []byte, error) {
	if i := bytes.Index(data, []byte("\n\n")); i >= 0 {
		return i + 2, data[0:i], nil
	}
	if atEOF && len(data) > 0 {
		return len(data), data, nil
	}
	return 0, nil, nil
}
