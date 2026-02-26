export GTK_THEME=Arc:dark
export GTK_MODULES=canberra-gtk-module
export XDG_SESSION_DESKTOP=i3
export XDG_SESSION_TYPE=x11
export QT_QPA_PLATFORMTHEME=qt6ct

# Ensure XDG_RUNTIME_DIR is set
if test -z "$XDG_RUNTIME_DIR"; then
    export XDG_RUNTIME_DIR=$(mktemp -d /tmp/$(id -u)-runtime-dir.XXX)
fi

xinput set-prop 'ELAN1205:00 04F3:30E9 Touchpad' 'libinput Tapping Enabled' 1
xinput set-button-map 'ELAN1205:00 04F3:30E9 Touchpad' 1 2 3
setxkbmap lv

picom &

exec i3
