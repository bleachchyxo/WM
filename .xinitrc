[ -f ~/.xprofile ] && . ~/.xprofile

while true; do

        # Battery remaining
        [ -f "/sys/class/power_supply/BAT0/capacity" ] && BSTAT="$(cat /sys/class/power_supply/BAT0/capacity)/100" || BSTAT="Cable connected"

        # Wifi status
        WSIGN="$(awk '/wlan0/ {print substr($3,1,2)}' /proc/net/wireless)"
        WSIGN=$((WSIGN * 10 / 7))
        [ $WSIGN -lt 1 ] && WSTAT="Offline"
        [ $WSIGN -gt 0 ] && WSTAT="#:::::::::"
        [ $WSIGN -gt 10 ] && WSTAT="##::::::::"
        [ $WSIGN -gt 20 ] && WSTAT="###:::::::"
        [ $WSIGN -gt 30 ] && WSTAT="####::::::"
        [ $WSIGN -gt 40 ] && WSTAT="#####:::::"
        [ $WSIGN -gt 50 ] && WSTAT="######::::"
        [ $WSIGN -gt 60 ] && WSTAT="#######:::"
        [ $WSIGN -gt 70 ] && WSTAT="########::"
        [ $WSIGN -gt 80 ] && WSTAT="#########:"
        [ $WSIGN -gt 90 ] && WSTAT="##########"

        # Status render
        xsetroot -name " Wifi: [$WSTAT] | Battery: $BSTAT | $(date '+%d/%m/%Y %H:%M') "
        sleep 1

done &
xcompmgr -cC -t5 -r2.2 -o.25 &
exec dwm
