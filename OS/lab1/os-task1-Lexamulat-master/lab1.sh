#!/bin/bash

echo 'start'

# touch results.xml

echo "<dnslog>" > results.xml

tail -n 50  dns-tunneling.log | awk '{
    print "<row>"
    print "\t<timestamp>" $4 "</timestamp>"
    print "\t<client_ip>"$5"</client_ip>"
    print "\t<client_port>"$6"</client_port>"
    print "</row>"
}
' >> results.xml


echo "</dnslog>" >> results.xml

