#!/bin/bash
#This is a script to convert hex dump from ASA/FTD show capture capname dump to pcap
#version 1

# Exit Codes
E_NOFILE=91           # Dump File does not exist
E_NOTEXTFILE=92       # File does not look like text file.

# Argument validation check
if [ "$#" -ne 2 ]; then
    echo ""
    echo "Usage Guidelines"
    echo "Example: $0 file.text abc.pcap"
    echo "Text file will be output of /show capture "capname" dump/ from ASA/FTD"
    echo "Second argument will be the name of the pcap file to be created"
    echo ""
    exit 1
fi

#Parameters entered by user

filename=$1

if [ ! -f $filename ]
   then
	   echo "Capture Dump File not found"
	   exit $E_NOFILE
fi # Check if dump file exists.

if file "$filename" | grep -q text$; then
    		:
	else
    		echo "Capture Dump File does not look like a text file"
		exit $E_NOTEXTFILE
fi


awk '/0x/ {
string=$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9
gsub("0x", "00", string)
gsub("000000", "\n000000", string)
$0=string
for(i=2; i<=NF; i++)
{
	val=$i
	fstr=substr(val,1,2)
	sstr=substr(val,3,2)
#	printf("%s %s\n",fstr,sstr)
	val=fstr" "sstr
	$i=val
	
	
}
print $0
}' $filename | text2pcap - $2

