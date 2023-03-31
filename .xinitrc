[ -f ~/.xprofile ] && . ~/.xprofile
bat_path=/sys/class/power_supply/BAT0
wifi_path=/sys/class/net/wlp3s0
eth_path=/sys/class/net/enp0s25

while true; do

        # Volume
        vstat="$(amixer get Master | awk -F'[][]' 'END{ print ""$2 }')"

        # Battery remaining
        if [ -e "$bat_path/capacity" ]; then
                read -r bstat <"$bat_path/capacity"
                read -r bat_status <"$bat_path/status"
                btitle="| BAT: "
                per="% "
                bend="|"
        else
                bstat="|"
                bat_status=
                btitle=
                per=
                bend=
        fi

        # Charging
        if [ "$bat_status" = Charging ]; then
                cstat="⚡ "
        else
                cstat=
        fi

        # Connection status
        read -r wifi_state <"$wifi_path/operstate"
        read -r ethernet_state <"$eth_path/operstate"
        if [ "$wifi_state" = up ] || [ $ethernet_state = up ]; then
                wstat=Up
        else
                wstat=Down
        fi

        # Status render
        xsetroot -name " WEB: $wstat $btitle$bstat$per$cstat$bend VOL: $vstat | $(date '+%d/%m/%Y %H:%M') "
        sleep 1

done &
exec dwm
