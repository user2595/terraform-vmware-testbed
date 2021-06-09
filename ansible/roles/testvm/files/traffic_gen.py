#! /usr/bin/env python

import sys, random
from scapy.all import send, IP, fuzz, UDP, NTP, TCP

def sendFuzzedUDP(dstIP):
    send(IP(dst=dstIP)/fuzz(UDP()), count=100)

def sendFuzzedTCP(dstIP):
    send(IP(dst=dstIP)/fuzz(TCP()), count=100)

def sendForList(list):
    for ip in list:
        if random.randint(1, 2) < 2:
            sendFuzzedUDP(ip)
        else:
            sendFuzzedTCP(ip)

ips = []

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Too few arguments!\n\nUsage: \tpython traffic_gen.py <ip addresses to send fuzzed packets to>\ne.g. \tpython traffic_gen.py 127.0.0.1 192.168.0.1")
        sys.exit(1)

    for i in range(1, len(sys.argv)):
        ips.append(sys.argv[i])

    sendForList(ips)

# For documentation of library see: https://scapy.readthedocs.io/en/latest/usage.html