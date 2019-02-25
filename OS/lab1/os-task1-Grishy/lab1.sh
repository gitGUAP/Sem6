#!/bin/bash

echo "{" > results.json

awk '
NR>51 && NR<=100 {
    printf "%s\t\"%s\": {\n\t\t\"timestamp\": %s,\n\t\t\"client ip\": \"%s\",\n\t\t\"client port\": %s\n\t}",
        separator, $3, $4, $5, $6
    separator = ",\n"
}' dns-tunneling.log >> results.json

printf "\n}\n" >> results.json
