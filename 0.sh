#!/bin/bash

## Add your ISO configurations here.
## This is executed as root before calamares is started.

# make the changes to pacman.conf
# Misc options
#UseSyslog
Color
#NoProgressBar
CheckSpace
VerbosePkgLists
ParallelDownloads = 10
IloveCandy

# make my grub changes 
GRUB_FORCE_HIDDEN_MENU="true"
GRUB_DISTRIBUTOR="Arch"
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_FONT="/boot/grub/fonts/ter-x20b.pf2"
GRUB_HIDDEN_TIMEOUT=1
GRUB_HIDDEN_TIMEOUT_QUIET="true"
GRUB_CMDLINE_LINUX_DEFAULT="root=PARTUUID=000153f1-e9d0-fd5a-8de0-fb15e2a70200 rw quiet loglevel=0 rd.systemd.show_status=false rd.udev.log-priority=0 vt.global_cursor_default=0"
grub-mkconfig -o /boot/grub/grub.cfg
sed -i 's/echo/#ech~o/g' /boot/grub/grub.cfg

# Add your "late-install" commands here.
# This is executed as root near the end of calamares execution.

_PostInstallCommands() {
    local -r username="$1"              # new user you created for the target

    # Now your commands. Some examples:
    #
    # echo "## Hello world!"           >> /home/$username/.bashrc
    # echo "export FUNCNEST=100"       >> /home/$username/.bashrc
    # echo "alias pacdiff=eos-pacdiff" >> /home/$username/.bashrc
    # chmod $username:$username           /home/$username/.bashrc

    # Install necessary packages
    pacman -S --noconfirm --needed automake autoconf autoconf-archive base-devel multilib-devel plymouth sddm mpv vlc notepadqq geany geany-plugins nano
    git clone https://github.com/l1nux-th1ngz/feb.git

    # Execute first boot script
    cd feb && chmod 777 5.sh && ./5.sh

    # Change permissions for .bashrc
    chmod 644 /home/$username/.bashrc
}

# Wait for something (Specify what you want to wait for)
