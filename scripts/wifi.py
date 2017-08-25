#!/usr/bin/python3
# wifi.py: a tool to print wifi information
# should run pretty quickly
import sys, subprocess

verbose = False

p = subprocess.Popen(['iwgetid','-r'], stdout=subprocess.PIPE)
iwResult = p.communicate()[0].decode("utf-8").strip()
if not iwResult:
    sys.stdout.write("<fn=1></fn> Not Connected\n")
    exit()

cmd = "iwconfig wlp3s0 | grep Signal | awk '{print $4}' | cut -d'=' -f2"
strDbm = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE).communicate()[0].decode("utf-8").strip()
dbMax = -45
dbMin = -85
signalStrength = str(int(100*(1-((dbMax-int(strDbm))/(dbMax-dbMin))))) # str(min(2*(int(strDbm)+100),100))
sys.stdout.write("<fn=1></fn> " + iwResult )
if verbose:
    sys.stdout.write(" (" + strDbm + " dBm)")
else:
    sys.stdout.write(" (" + signalStrength + "%)")
sys.stdout.flush()
