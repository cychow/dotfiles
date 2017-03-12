# Read from Xresources file so things aren't sad and white
xrdb ~/.Xresources
# Start compton (because screen tearing is sad)
compton -b
exec xmonad
