#!/usr/bin/python3
# getvolume.py: a tool to print volume information
# should run pretty quickly
import sys, subprocess, re
try:
    muted = "amixer sget Master | awk -F\"[ ]\" '/\[o.+\]/' | grep -c \"\[off\]\" >/dev/null"
    p = subprocess.Popen([muted], stdout=subprocess.PIPE,shell=True)
    p.communicate()
    if not p.returncode:
        sys.stdout.write("<fn=1></fn> Muted\n")
        exit()
    cmd = "amixer sget Master"
    strVolume = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE).communicate()[0].decode("utf-8").split('\n')
    Volume = int(re.search('\[([0-9]+)%\]',strVolume[-2]).group(1))
    if Volume < 20:
        volchar = ""
    elif Volume < 50:
        volchar = ""
    else:
        volchar = ""
    print('<fn=1>' + volchar + '</fn> ' + str(Volume) + '%')
except Exception as e:
    print(e)