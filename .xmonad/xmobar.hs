Config {
    position = Top,
    alpha = 128,
    font =  "xft:SFNS Display:size=11,xft:FontAwesome:pixelsize=15",
    additionalFonts = ["xft:FontAwesome:pixelsize=15"],
    --template = "%battery% | %multicpu% | %coretemp% | %dynnetwork% }%StdinReader%{ %date%", 
    template = " %battery%    %volume%    %brightness%    %wifi% }%StdinReader%{ %spotify% %date% ", 
    commands = 
    [
        Run DynNetwork ["--template", "<dev>: <tx>kB/s|<rx>kB/s",
            "--Low",	"1000",	-- units: B/s
            "--High",	"5000",
            "--low",	"#669900",
            "--normal",	"#ff8800",
            "--high",	"#ff4444"
        ] 10,
	    Run MultiCpu ["--template", "CPU: <total0>%|<total1>%",
            "--Low",	"50",
            "--High",	"85",
            "--low",    "#669900",
            "--normal", "#ff8800",
            "--high",   "#ff4444"
        ] 10,        
        Run CoreTemp ["--template", "Temp:<core0>°C|<core1>°C",
            "--Low",    "70",
            "--High",   "80",
            "--low",    "#669900",
            "--normal", "#ff8800",
            "--high",   "#ff4444"
        ] 50,
        Run Battery ["--template", "<acstatus>",
            "--Low",    "10",
            "--High",   "80",
            "--low",    "#ff4444",
            "--normal", "#cd924e",
            "--high",    "#9fb852",
            -- Discharging
            "--",
            "-o","<left>% (<timeleft>)",
            -- AC "on"
            "-O","<fn=1>\xf0e7</fn> <left>% (<timeleft>)",
            -- Charged
            "-i","<fn=1>\xf0e7</fn> <left>%"
        ] 50,
        Run Date "%-m/%-e/%G   %-I:%M %p" "date" 10,
        Run StdinReader,
        Run Com "/usr/bin/python3" ["/home/chris/scripts/getvolume.py"] "volume" 1,
        Run Com "/usr/bin/python3" ["/home/chris/scripts/wifi.py"] "wifi" 50,
        Run Com "/usr/bin/python3" ["/home/chris/scripts/spotify.py"] "spotify" 10,
        Run Com "/usr/bin/python3" ["/home/chris/scripts/brightness.py"] "brightness" 9
        
        ]
}
