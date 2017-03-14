#!/bin/bash
vol="$(awk -F"[][]" '/\%/ { print $2 }' <(amixer sget Master))"
var="amixer sget Master | awk -F\"[ ]\" '/\[o.+\]/' | grep -c \"\[off\]\" >/dev/null"
if eval $var; then
	# echo "${VOL} (M)"
	echo "<fn=1></fn> Muted"
else
	volume=$(grep -oE '[^ ]*[^%]' <<< $vol)
	
	# echo $volume
	if [ "$("$volume")" -gt "50" ] ; then
		echo "Vol: ${vol}"
	else
		echo "50: ${vol}"
	fi
fi
