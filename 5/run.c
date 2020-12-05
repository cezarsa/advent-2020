//usr/bin/clang -Wall -Werror -pedantic -o /tmp/5.out "$0" && exec /tmp/5.out "$@"

#include <stdio.h>
#include <stdlib.h>

int seat_id(char* line)
{
    int i;
    int inc;
    int rowMin = 0, rowMax = 127;
    int colMin = 0, colMax = 7;

    for (i = 0; i <= 6; i++) {
        inc = ((rowMax - rowMin) + 1) / 2;
        if (line[i] == 'F') {
            rowMax -= inc;
        } else if (line[i] == 'B') {
            rowMin += inc;
        }
    }

    for (i = 7; i <= 9; i++) {
        inc = ((colMax - colMin) + 1) / 2;
        if (line[i] == 'L') {
            colMax -= inc;
        } else if (line[i] == 'R') {
            colMin += inc;
        }
    }

    return (rowMin * 8) + colMin;
}

void part1(FILE* f)
{
    char* line = NULL;
    size_t linecap = 0;
    ssize_t linelen;
    int id, max_id = -1;

    while ((linelen = getline(&line, &linecap, f)) > 0) {
        id = seat_id(line);
        if (id > max_id)
            max_id = id;
    }
    free(line);

    printf("%d\n", max_id);
}

void part2(FILE* f)
{
    char* line = NULL;
    size_t linecap = 0;
    ssize_t linelen;
    int id, max_id = -1;
    char seats[1024] = { 0 };

    while ((linelen = getline(&line, &linecap, f)) > 0) {
        id = seat_id(line);
        seats[id] = 1;
        if (id > max_id)
            max_id = id;
    }
    free(line);

    for (id = max_id; id > 0; id--) {
        if (!seats[id]) {
            printf("%d\n", id);
            return;
        }
    }
}

int main()
{
    FILE* f;

    f = fopen("input", "rb");
    if (f == NULL)
        return -1;

    part1(f);
    rewind(f);
    part2(f);

    fclose(f);
    return 0;
}
