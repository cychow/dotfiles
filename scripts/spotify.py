# spotify.py
# spotify StdinReader statusbar script
# currently being used on xmonad
import sys, subprocess, textwrap

# get currently running track in spotify
command = ["/home/chris/scripts/sp.sh", "current"]
currString = subprocess.Popen(command,stdout=subprocess.PIPE).communicate()[0].decode("utf-8").strip()
#print(currString)
if currString == "Error: Spotify is not running.":
    # Spotify isn't running so don't worry about it...
    print("")
    exit()
# split by lines
currentData = currString.split('\n')
#print(currentData)
try:
    artist = currentData[2][6:].strip()
    title = currentData[3][5:].strip()
    wrappedText = textwrap.shorten(artist + " - " + title, width=70, placeholder="...")
    print(u"<fc=#669900><fn=1></fn></fc> " + wrappedText + u'   ')
except Exception as e:
    #print("error reading spotify info: " + str(e))
    exit()
