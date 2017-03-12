#!/bin/bash
VOL="$(awk -F"[][]" '/\%/ { print $2 }' <(amixer sget Master))"
VAR="amixer sget Master | awk -F\"[ ]\" '/\[o.+\]/' | grep -c \"\[off\]\" >/dev/null"
if eval $VAR; then
	# echo "${VOL} (M)"
	echo "Vol: Muted"
else
	echo "Vol: ${VOL}"
fi
