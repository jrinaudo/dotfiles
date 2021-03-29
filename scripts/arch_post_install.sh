#!/bin/sh

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
sudo pacman -S --needed --noconfirm
alacritty \
alsa-utils \
arandr \
arc-gtk-theme \
arc-icon-theme \
base-devel \
bash-completion \
blueman \
bluez \
bluez-utils \
bzip2 \
code \
compton \
dunst \
ffmpegthumbnailer \
figlet \
file-roller \
filezilla \
fzf \
gimp \
git \
gnome-screenshot \
gvfs \
gvfs-mtp \
gvim \
gzip \
i3-wm \
i3blocks \
i3lock \
inkscape \
libnotify \
lxappearance-gtk3 \
mesa \
mlocate \
networkmanager \
nitrogen \
noto-fonts-emoji \
ntfs-3g \
numlockx \
openssh \
p7zip \
pavucontrol \
polkit \
polkit-gnome \
pulseaudio \
pulseaudio-alsa \
pulseaudio-bluetooth \
ristretto \
rofi \
thunar \
thunar-archive-plugin \
thunar-media-tags-plugin \
transmission-gtk \
ttf-croscore \
ttf-dejavu \
ttf-font-awesome \
ttf-inconsolata \
ttf-roboto \
ttf-ubuntu-font-family \
tumbler \
unrar \
unzip \
vlc \
wpa_supplicant \
xdg-user-dirs \
xorg-server \
xorg-xinit \
xorg-xset \
xz \
zip

# Install yay, a pacman wrapper with AUR support
git clone https://aur.archlinux.org/yay.git \
&& cd yay \
&& makepkg -si \
&& yay -S google-chrome ttf-monaco ttf-yosemite-san-francisco-font-git

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

