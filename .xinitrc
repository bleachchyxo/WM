[ -f ~/.xprofile ] && . ~/.xprofile

while true; do

        # Battery remaining
        [ -f "/sys/class/power_supply/BAT0/capacity" ] && BSTAT="$(cat /sys/class/power_supply/BAT0/capacity)" || BSTAT="Cable connected"

        # WIFI Status
       #STAT="$(iwlist wlan0 rate | awk '/Rate=/ {print substr($3, 6, 5)}')"
       #WSTAT="$(awk '/wlan0/ {print substr($3,1,2)}' /proc/net/wireless)"
       #WSTAT=$((WSTAT * 10 / 7))

        wifi_interface="wlan0"
        WSTAT=" "

        getStatus(){
                cat /sys/class/net/$1/operstate
        }

        uploadSpeed(){
                tx2=$(cat /sys/class/net/$1/statistics/tx_bytes)
                uspeed=$(numfmt --to=iec $((tx2-tx1)))
        }

        downloadSpeed(){
                rx2=$(cat /sys/class/net/$1/statistics/rx_bytes)
                dspeed=$(numfmt --to=iec $((rx2-rx1)))
        }

        if [ "$(getStatus $wifi_interface)" = "up" ]; then
                downloadSpeed $wifi_interface
                uploadSpeed $wifi_interface
                WSTAT="▼$dspeed/$uspeed▲"
        else
                WSTAT="Offline"
        fi

        tx1=$(cat /sys/class/net/$1/statistics/tx_bytes)
        rx1=$(cat /sys/class/net/$1/statistics/rx_bytes)
        
        
        # Volume
        VSTAT="$(amixer get Master | awk -F'[][]' 'END{ print $2 }')"

        # Status render
        xsetroot -name " BAT $BSTAT% | $WSTAT | VOL $VSTAT | $(date '+%r')"
        sleep 1

done &
exec dwm
