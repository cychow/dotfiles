# brightness.py
# get screen brightness and display as a percent
import subprocess, math
command = ['cat', '/sys/class/backlight/intel_backlight/brightness']
brightness = int(subprocess.Popen(command,stdout=subprocess.PIPE).communicate()[0].decode("utf-8").strip())
# magical spooky logarithmic scaling for brightness from 52 to 4400
percentage = int(((math.log(brightness)-3.951243)/(8.397733751-3.951243))*100)
print(u"<fn=1></fn> " + str(percentage) + '%')
