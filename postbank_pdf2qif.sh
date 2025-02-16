#!/usr/bin/env bash

SCRIPT=`basename $0`

fail_usage() {
    >&2 echo "usage: $SCRIPT <pdf_file>"
    >&2 echo "$1"
    exit 1
}


[ "$#" = "1" ] || fail_usage
INPUT=$1
[ -f "$INPUT" ] || fail_usage "$INPUT is not a file"

OUTPUT=${INPUT%.pdf}.qif

postbank_pdf2txt.sh $INPUT | postbank_txt2table.awk | postbank_table2csv.awk | postbank_csv2qif.py > $OUTPUT
