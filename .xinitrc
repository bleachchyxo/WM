while true; do

	# Battery remaining
	BSTAT=$(cat /sys/class/power_supply/BAT0/capacity)
	
	# Wifi status
	WSTAT="$(awk '/wlan0/ {print substr($3,1,2)}' /proc/net/wireless)"
	WSTAT=$((WSTAT * 10 / 7))
  
	# Status render
	xsetroot -name " WIFI $WSTAT% | BAT $BSTAT/100 | $(date '+%Y.%m.%d %H:%M:%S')"
	sleep 1
  
done &
exec dwm
