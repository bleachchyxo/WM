[ -f ~/.xprofile ] && . ~/.xprofile

while true; do

        # Battery remaining
        [ -f "/sys/class/power_supply/BAT0/capacity" ] && BSTAT="$(cat /sys/class/power_supply/BAT0/capacity)/100" || BSTAT="Cable connected"

        # Wifi status
        WSTAT="$(awk '/wlan0/ {print substr($3,1,2)}' /proc/net/wireless)"
        WSTAT=$((WSTAT * 10 / 7))

        # Status render
        xsetroot -name " Wifi: $WSTAT% | Battery: $BSTAT | $(date '+%d/%m/%Y %H:%M') "
        sleep 1

done &
exec dwm
