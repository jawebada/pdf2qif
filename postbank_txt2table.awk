#!/usr/bin/awk -f
BEGIN { regex1 = "^ {40}[a-zA-Z0-9]"; regex2 = "^ {19}[0-9]{2}[0-9.][0-9]" }
$0 ~ regex1 || $0 ~ regex2 { print substr($0, 20) }
