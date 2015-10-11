#!/bin/bash

apt-get --yes install firefox chromium-browser
apt-get --yes install xfce4
apt-get --yes install gnome-core
cd
wget http://launchpadlibrarian.net/128479899/vnc4server_4.1.1%2Bxorg4.3.0-37ubuntu5_armhf.deb
dpkg -i vnc4server_*.deb
apt-get --yes -f install
dpkg -i vnc4server_*.deb
rm vnc4server_*.deb
vncserver
vncserver -kill :1
cd ~/.vnc/
mv xstartup xstartup.bak
wget https://raw.githubusercontent.com/hhsungur/gnome-desktop-autoinstall/master/xstartup --no-check-certificate
chmod +x xstartup
cd /etc/init.d/
wget https://raw.githubusercontent.com/hhsungur/gnome-desktop-autoinstall/master/vncserver --no-check-certificate
chmod +x vncserver
mkdir -p /etc/vncserver
cd /etc/vncserver/
wget https://raw.githubusercontent.com/hhsungur/gnome-desktop-autoinstall/master/vncservers.conf
update-rc.d vncserver defaults 99