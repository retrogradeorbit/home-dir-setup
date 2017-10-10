add-apt-repository -y ppa:webupd8team/java

apt-get update
apt-get -y install oracle-java8-installer build-essential emacs \
        libpango1.0-0 libappindicator1 git pulseaudio dkms \
        xmonad libghc-xmonad-contrib-dev xmobar stalonetray \
        suckless-tools scrot cabal-install xcompmgr

# xmonad stuff
cabal update
cabal install --global yeganesh

# audio on modern intel hda audio laptop
apt-add-repository -y ppa:ubuntu-audio-dev/alsa-daily
apt-get -y install oem-audio-hda-daily-lts-xenial-dkms

# keypress tools
apt-get -y install xbacklight

# you are going to need these to install emacs from source
apt-get -y install git libxaw7-dev libjpeg-dev libgif-dev libtiff-dev

# extra desktop utilities
apt-get -y install xscreensaver curl
