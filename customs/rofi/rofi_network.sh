
#!/bin/bash

# Option to scan for available Wi-Fi networks and connect
connect_to_wifi() {
    CHOICE=$(nmcli -t -f ssid,signal dev wifi | rofi -dmenu -p "Available Networks:")

    if [[ -n "$CHOICE" ]]; then
        SSID=$(echo "$CHOICE" | cut -d':' -f1)
        nmcli dev wifi connect "$SSID"
    fi
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
