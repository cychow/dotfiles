import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import System.IO

--baseConfig = desktopConfig

--main = xmonad =<< xmobar $ baseConfig
--main = do
--  xmproc 
--  xmonad $ defaultConfig

myTerminal  = "urxvt"
myModMask = mod4Mask
myBorderWidth = 3
-- uhh what
-- myLayout = avoidStruts  $  layoutHook defaultConfig
-- myTabbed = tabbed shrinkText defaultTheme {
--   fontName = "xft:Droid Sans Mono:size=12:antialias=true",
--   activeBorderColor = "#33b5e5"
-- }

myLayout = desktopLayoutModifiers $ Tall 1 0.03 0.05 ||| Grid ||| Full
myManageHook = composeAll
  [
  className =? "lightscreen" --> doFloat,
  className =? "netctl-gui" --> doFloat,
  className =? "xMessage"    --> doFloat
  ]

main = do    
    xmproc <- spawnPipe "xmobar"
    xmonad $ desktopConfig
      { terminal		= myTerminal,
      layoutHook = myLayout,
      manageHook = myManageHook <+> manageHook desktopConfig,
      logHook = dynamicLogWithPP $ defaultPP 
        { ppOutput = hPutStrLn xmproc,
          ppTitle = xmobarColor "#33b5e5" "" . shorten 50
        },
      modMask		= myModMask,
      borderWidth		= myBorderWidth,
      normalBorderColor	= "#555555",
      focusedBorderColor	= "#33b5e5",
      clickJustFocuses    = False,
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
      ((0, 0x1008FF17), spawn "/home/chris/scripts/sp.sh next")
      ]
