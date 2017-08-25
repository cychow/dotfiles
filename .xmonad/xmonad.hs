import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.Fullscreen
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
--import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import System.IO

--baseConfig = desktopConfig

--main = xmonad =<< xmobar $ baseConfig
--main = do
--  xmproc 
--  xmonad $ defaultConfig

myTerminal  = "urxvt"
myStartupHook = docksStartupHook
myModMask = mod4Mask
myBorderWidth = 2
-- uhh what
-- myLayout = avoidStruts  $  layoutHook defaultConfig
-- myTabbed = tabbed shrinkText defaultTheme {
--   fontName = "xft:Droid Sans Mono:size=12:antialias=true",
--   activeBorderColor = "#214f5e"
-- }

myLayout = (smartBorders . avoidStruts $
  (fullscreenFocus $ ( 
  spacing 4 $ gaps [(U,0), (D,2), (R,2), (L,2)]
   $ Tall 1 0.025 0.5 ||| Grid ))) ||| noBorders Full



myManageHook = composeAll . concat $
  [
  [className =? "Lightscreen" --> doFloat],
  [className =? "netctl-gui" --> doFloat],
  [className =? "xMessage" --> doFloat],
  [className =? "Spotify" --> doFloat],
  [className =? "xfce4-notifyd-config" --> doFloat],
  [className =? "crx_chlffgpmiacpedhhbkiomidkjlcfhogd" --> doFloat]
  ]

urgentColor = "#cd924e"
currentColor = "#63a4bc"
titleColor = "#63a4bc"

myfullscreenEventHook = fullscreenEventHook <+> docksEventHook

main = do    
    xmproc <- spawnPipe "xmobar /home/chris/.xmonad/xmobar.hs"
    xmonad $ desktopConfig
      { terminal = myTerminal,
      workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
      layoutHook = myLayout,
      startupHook = myStartupHook,
      manageHook = myManageHook <+> manageHook desktopConfig,
      logHook = dynamicLogWithPP $ defaultPP 
        { ppOutput = hPutStrLn xmproc,
          ppUrgent = xmobarColor "#cd924e" "",
          ppCurrent = xmobarColor "#63a4bc" "" . wrap "[" "]",          
          ppTitle = xmobarColor "#63a4bc" "" . shorten 70,
          ppLayout = (\ x -> pad $ case x of 
                        "Spacing 10 Tall" -> "Tall"
                        "Spacing 10 Grid" -> "Grid"
                        "Full"            -> "Full"
                        _                 ->  x
                     )
        },
      modMask		= myModMask,
      borderWidth		= myBorderWidth,
      normalBorderColor	= "#555555",
      focusedBorderColor	= "#63a4bc",
      clickJustFocuses    = False,
      handleEventHook = myfullscreenEventHook,
      focusFollowsMouse   = False
      } 
      `additionalKeys`
      [
      ((0, 0x1008FF11), spawn "amixer set Master 2%-; pactl set-sink-mute 0 0"),
      ((0, 0x1008FF13), spawn "amixer set Master 2%+; pactl set-sink-mute 0 0"),
      ((0, 0x1008FF12), spawn "pactl set-sink-mute 0 toggle"),
      ((0, 0x1008FFB2), spawn "amixer set Capture toggle"),
      ((0, 0x1008ff16), spawn "/home/chris/scripts/sp.sh prev"),
      ((0, 0x1008ff14), spawn "/home/chris/scripts/sp.sh play"),
      ((0, 0x1008FF17), spawn "/home/chris/scripts/sp.sh next"),
      --((mod4Mask, 0x6c), spawn "xscreensaver-command -lock"),
      ((0, 0x1008ff2d),  spawn "xscreensaver-command -lock"),
      ((mod4Mask, 0x70), spawn "rofi -show drun"),
      ((0, 0x0000ff61), spawn "scrot ~/Documents/Screenshots/%b-%d-%H:%M:%S.png")
      ]
