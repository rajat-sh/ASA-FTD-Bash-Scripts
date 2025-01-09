# Introduction

During troubleshooting on webex, there is sometimes requirement to quickly check packet details from capture multiple times. Customer might not have wireshark installed and transferring
captures usually takes time. Using the script one can copy text on webex and convert to pcap without need of file transfer.

# Requisites

Linux PC with text2pcap installed

# Script Usage

$ ./dump_pcap.sh 

Usage Guidelines
Example: ./dump_pcap.sh file.text abc.pcap
Text file will be output of /show capture capname dump/ from ASA/FTD
Second argument will be the name of the pcap file to be created


This is an example of capture dump file taken from ASA.

$ cat example.dump 
35455: 19:12:23.016554       10.56.229.160.65387 > 10.48.26.235.22: . ack 3067659546 win 65535
0x0000	 0050 568d a17a 4c71 0d9d b9ff 0800 4548	.PV..zLq......EH
0x0010	 0028 0000 4000 3406 3195 0a38 e5a0 0a30	.(..@.4.1..8...0
0x0020	 1aeb ff6b 0016 bfe5 8deb b6d8 c51a 5010	...k..........P.
0x0030	 ffff d19a 0000                         	...... 
35456: 19:12:23.016554       10.56.229.160.65387 > 10.48.26.235.22: . ack 3067659646 win 65535
0x0000	 0050 568d a17a 4c71 0d9d b9ff 0800 4548	.PV..zLq......EH
0x0010	 0028 0000 4000 3406 3195 0a38 e5a0 0a30	.(..@.4.1..8...0
0x0020	 1aeb ff6b 0016 bfe5 8deb b6d8 c57e 5010	...k.........~P.
0x0030	 ffff d136 0000                         	...6.. 
35457: 19:12:23.016554       10.56.229.160.65387 > 10.48.26.235.22: . ack 3067659746 win 65535
0x0000	 0050 568d a17a 4c71 0d9d b9ff 0800 4548	.PV..zLq......EH
0x0010	 0028 0000 4000 3406 3195 0a38 e5a0 0a30	.(..@.4.1..8...0
0x0020	 1aeb ff6b 0016 bfe5 8deb b6d8 c5e2 5010	...k..........P.
0x0030	 ffff d0d2 0000                         	...... 
35458: 19:12:23.016570       10.56.229.160.65387 > 10.48.26.235.22: . ack 3067659846 win 65535
0x0000	 0050 568d a17a 4c71 0d9d b9ff 0800 4548	.PV..zLq......EH
0x0010	 0028 0000 4000 3406 3195 0a38 e5a0 0a30	.(..@.4.1..8...0
0x0020	 1aeb ff6b 0016 bfe5 8deb b6d8 c646 5010	...k.........FP.
0x0030	 ffff d06e 0000                         	...n.. 

# Run the Script

$ ./dump_pcap.sh example.dump jan9.pcap
Input from: Standard input
Output to: jan9.pcap
Output format: pcapng

-------------------------
Read 4 potential packets, wrote 4 packets (612 bytes including overhead).

Check the PCAP file generated using tshark on CLI and Wireshark

(base) RAJATSH-M-V7QW:Desktop rajatsh$ tshark -r jan9.pcap 
1 10.56.229.160 → 10.48.26.235 TCP 65387 → 22 [ACK] Seq=3219492331 Ack=3067659546 Win=65535 Len=0
2 10.56.229.160 → 10.48.26.235 TCP 65387 → 22 [ACK] Seq=3219492331 Ack=3067659646 Win=65535 Len=0
3 10.56.229.160 → 10.48.26.235 TCP 65387 → 22 [ACK] Seq=3219492331 Ack=3067659746 Win=65535 Len=0
4 10.56.229.160 → 10.48.26.235 TCP 65387 → 22 [ACK] Seq=3219492331 Ack=3067659846 Win=65535 Len=0
(base) RAJATSH-M-V7QW:Desktop rajatsh$ open -a wireshark jan9.pcap
