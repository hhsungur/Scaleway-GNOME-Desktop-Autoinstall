#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

read -p "Port: " -e -i 1 PORT
read -p "Rosolution: " -e -i 1280x720 RESOLUTION

apt-get --yes update

cd
wget http://launchpadlibrarian.net/128479899/vnc4server_4.1.1%2Bxorg4.3.0-37ubuntu5_armhf.deb
dpkg -i vnc4server_*.deb
apt-get --yes -f install
dpkg -i vnc4server_*.deb
rm vnc4server_*.deb
vncserver :$port

apt-get --yes install firefox chromium-browser
apt-get --yes install xfce4
apt-get --yes install gnome-core

cd ~/.vnc/
mv xstartup xstartup.bak
wget https://raw.githubusercontent.com/hhsungur/gnome-desktop-autoinstall/master/xstartup --no-check-certificate
chmod +x xstartup

cd /etc/init.d/
wget https://raw.githubusercontent.com/hhsungur/gnome-desktop-autoinstall/master/vncserver --no-check-certificate
chmod +x vncserver

mkdir -p /etc/vncserver
cd /etc/vncserver/
touch vncservers.conf
echo 'VNCSERVERS="'$PORT':root"' | tee -a /etc/vncserver/vncservers.conf
echo 'VNCSERVERARGS[1]="-geometry '$RESOLUTION'"' | tee -a /etc/vncserver/vncservers.conf
update-rc.d vncserver defaults 99
reboot