
#!/bin/bash

# Option to scan for available Wi-Fi networks and connect
connect_to_wifi() {
  hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:11 Getting list of available Wi-Fi networks..."
  wifi_list=$(nmcli --fields "IN-USE,SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S|WEP*.?\s/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "s/* /Connected: /g" | sort -k 1,1r)

  connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="󰖪  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
	toggle="󰖩  Enable Wi-Fi"
fi

# Use rofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: " )
# Get name of connection
read -r chosen_id <<< "${chosen_network:3}"
if [ "$chosen_network" = "" ]; then
	exit
elif [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
	nmcli radio wifi off
else
	# Message to show when connection is activated successfully
  	success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
	# Get saved connections
	saved_connections=$(nmcli -g NAME connection)
  echo "saved : $saved_connections"
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		nmcli connection up id "$chosen_id" | grep "successfully" && hyprctl notify -1 4000 "rgb(ff1ea3)"  "Connection Established" "$success_message"
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(rofi -dmenu -p "Password: " )
		fi
		nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && hyprctl notify -1 4000 "rgb(ff1ea3)" "Connection Established" "$success_message"
    fi
fi


# CHOICE=$(nmcli -t -f ssid,signal dev wifi | rofi -dmenu -p "Available Networks:")
#
#     if [[ -n "$CHOICE" ]]; then
#         SSID=$(echo "$CHOICE" | cut -d':' -f1)
#         nmcli dev wifi connect "$SSID"
#     fi
}

# Option to list and show active VPN connections (using nmcli for simplicity)
vpn_info() {
    VPN_STATUS=$(nmcli connection show --active | grep vpn)

    if [[ -z "$VPN_STATUS" ]]; then
        echo "No VPN connections active" | rofi -dmenu -p "VPN Status"
    else
        echo "$VPN_STATUS" | rofi -dmenu -p "Active VPN Connection"
    fi
}

# Option to disconnect from a VPN
disconnect_vpn() {
    VPN_NAME=$(nmcli connection show --active | grep vpn | awk '{print $1}' | rofi -dmenu -p "Disconnect VPN:")
    
    if [[ -n "$VPN_NAME" ]]; then
        nmcli connection down "$VPN_NAME"
    fi
}

# Main Menu
main_menu() {
    CHOICE=$(echo -e "Connect to Wi-Fi\nView VPN Info\nDisconnect VPN" | rofi -dmenu -p "Network Manager")

    case "$CHOICE" in
        "Connect to Wi-Fi")
            connect_to_wifi
            ;;
        "View VPN Info")
            vpn_info
            ;;
        "Disconnect VPN")
            disconnect_vpn
            ;;
        *)
            exit 0
            ;;
    esac
}

# Call the main menu function
main_menu
