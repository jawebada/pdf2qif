#!/usr/bin/awk -f
BEGIN { FS="    +"; OFS=";" }
/^[0-9]{2}\.[0-9]{2}\./ {
    if (NR > 1) print trim(col1), trim(col2), trim(col3), trim(col4);
    col1 = $1; col2 = $2; col3 = $3; col4 = $4;
    block_line = 1;
}
! /^[0-9]{2}\.[0-9]{2}\./ {
    block_line++;
    if (block_line == 2) {
        col1 = col1 $1;
        col2 = col2 $2;
        col3 = col3 " " $3;
    } else {
        col3 = col3 " " trim($0);
    }
}
END { print trim(col1), trim(col2), trim(col3), trim(col4); }
function trim(s) { sub(/^ +| +$/, "", s); return s }
