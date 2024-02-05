#!/bin/bash

# Install system dependencies
yay -S --noconfirm gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus
yay -S --confirm hyprland

# Define loading icon function
function loading_icon() {
    local load_interval="${1}"
    local loading_message="${2}"
    local elapsed=0
    local loading_animation=( '—' "\\" '|' '/' )

    echo -n "${loading_message} "

    # Make the cursor not blink on top of the animation while it lasts
    tput civis
    trap "tput cnorm" EXIT
    while [ "${load_interval}" -ne "${elapsed}" ]; do
        for frame in "${loading_animation[@]}" ; do
            printf "%s\b" "${frame}"
            sleep 0.25
        done
        elapsed=$(( elapsed + 1 ))
    done
    printf " \b\n"
}

# Show loading animation
loading_icon 60 "I'm Installing!"

# Install applications
yay -S --noconfirm \
    kitty \
    dolphin \
    spotify \
    grimblast \
    swappy \
    firefox \
    rofi-lbonn-wayland-git \
    wofi \
    swww \
    swaylock \
    ags \
    eww \
    python \
    nodejs \
    go \
    npm \
    clib2 \
    gtk3 \
    gtk2 \
    gtk4 \
    gtk-layer-shell \
    automake \
    autoconf \
    autoconf-archive \
    kio5 \
    kioadmin \
    ffmpeg \
    gparted \
    gvfs \
    htop \
    btop \
    foot \
    zsh \
    neovim \
    neofetch \
    cava \
    cliphist \
    playerctl \
    brightnessctl \
    python3.6+ \
    python-mpv \
    python-mpd2 \
    musicbrainzngs

# Import additional code
for i in {001..100}; do
    sleep 1
    printf "\r $i =>25%   ==>50%   ===>75%        ===>100%"
done

# Clone gruvbox.hypr repository
git clone --depth=1 https://github.com/qxb3/gruvbox.hypr
cd gruvbox.hypr || exit

# Copy files to appropriate directories
cp -r font/* ~/.local/share/fonts
cp -r config/* ~/.config
cp -r .scripts ~/

# Provide information on configuring music player support
echo "Just a quick heads up: if you want to support multiple music players and not just Spotify, change the 'PLAYER variable' in config/eww/sidebar/scripts/music.sh"

# Restart the system
sudo reboot
