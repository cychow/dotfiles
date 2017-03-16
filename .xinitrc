# Read from Xresources file so things aren't sad and white
xrdb ~/.Xresources
# Start compton (because screen tearing is sad)
# xscreensaver -nosplash
xscreensaver -nosplash &
pgrep redshift &> /dev/null || redshift &> /dev/null &
compton -b --xrender-sync --xrender-sync-fence
feh --bg-center /home/chris/Documents/reaper_wallpaper_clean_1080_16_9.jpg
exec xmonad
