#!/usr/bin/env python3

import sys
import csv
from datetime import datetime

reader = csv.reader(sys.stdin, delimiter=';', quoting=csv.QUOTE_NONE)
print("!Type:Bank")
for row in reader:
    date = datetime.strptime(row[1], '%d.%m.%Y').strftime('%m/%d/%y')
    amount = float(row[3].replace(" ", "").replace(".", "").replace(",", "."))
    description = row[2]
    print("D", date)
    print("T", amount)
    print("P", description)
    print("^")
