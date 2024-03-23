#!/bin/sh

# Add my user to the administration group
sudo usermod -aG wheel rema

# Configure console keymap and font
sudo tee -a /etc/vconsole.conf > /dev/null <<EOT
KEYMAP=la-latin1
FONT=Lat2-Terminus16
EOT

# Configure and start ntp service
sudo tee /etc/systemd/timesyncd.conf > /dev/null <<EOT
[Time]
NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.fr.pool.ntp.org
EOT

# Configure iptables firewall
sudo tee /etc/iptables/iptables.rules > /dev/null <<EOT
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
:TCP - [0:0]
:UDP - [0:0]
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m conntrack --ctstate INVALID -j DROP
-A INPUT -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
-A INPUT -p udp -m conntrack --ctstate NEW -j UDP
-A INPUT -p tcp --tcp-flags FIN,SYN,RST,ACK SYN -m conntrack --ctstate NEW -j TCP
-A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
-A INPUT -p tcp -j REJECT --reject-with tcp-reset
-A INPUT -j REJECT --reject-with icmp-proto-unreachable
COMMIT
EOT

# Install basic programs
sudo pacman -S --needed
alacritty \
alsa-utils \
arandr \
base-devel \
bash-completion \
blueman bluez bluez-utils \
code \
exfatprogs \
figlet \
flat-remix flat-remix-gtk \
font-manager \
fzf \
gimp imagemagick inkscape \
git \
gnupg \
gvim \
i3-wm i3blocks i3lock dex gnome-screenshot lxappearance-gtk3 nitrogen picom rofi \
libimobiledevice \
libnotify \
mesa \
networkmanager \
noto-fonts-cjk \
openssh \
parcellite \
pass \
pavucontrol pipewire pipewire-alsa pipewire-audio pipewire-pulse wireplumber \
playerctl \
polkit lxsession-gtk3 \
ripgrep \
ristretto \
thunar gvfs gvfs-gphoto2 ffmpegthumbnailer thunar-archive-plugin thunar-media-tags-plugin tumbler webp-pixbuf-loader xdg-user-dirs \
transmission-gtk \
noto-fonts-emoji ttf-croscore ttf-dejavu ttf-font-awesome ttf-inconsolata ttf-roboto \
xarchiver bzip2 gzip p7zip unrar unzip xz zip \
vlc \
xorg-server xorg-xinit xorg-xset \
xss-lock

# Install yay, a pacman wrapper with AUR support
git clone https://aur.archlinux.org/yay.git \
&& cd yay \
&& makepkg -si \
&& yay -S brave-bin

# get pulseaudio to handle X11 bell events
sudo tee -a /etc/pulse/default.pa > /dev/null <<EOT
# audible bell
load-sample-lazy x11-bell /usr/share/sounds/freedesktop/stereo/bell.oga
load-module module-x11-bell sample=x11-bell
EOT

# Create the config file to set the X window system keyboard layout
localectl --no-convert set-x11-keymap latin

# Install bash-git-prompt, an informative git prompt for bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
cat >> ~/.bashrc <<EOT
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi
EOT

# Services
sudo systemctl enable NetworkManager.service
sudo systemctl enable systemd-timesyncd.service
sudo systemctl enable iptables.service
# If there is any SSD with TRIM support
# sudo systemctl enable fstrim.timer
# If there is any bluetooth adapter
# sudo systemctl enable bluetooth.service

