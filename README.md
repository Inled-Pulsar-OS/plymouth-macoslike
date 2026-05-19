
# Pulsa OS Plymouth theme for macOS like version



The optional dimensions are:  

square:           130px x 130px
rectangular:      244px x 130px



## Installation

If we assume that the unzipped theme folder is located in your download directory:  


Copy the finished theme to /usr/share/plymouth/themes:  


cd ~/Downloads  


sudo cp -r pulsar-plymouth /usr/share/plymouth/themes  




## Installation Examples (from the original repo)

### Ubuntu/Linux Mint/Tuxedo OS

sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/pulsar-plymouth/pulsar-plymouth.plymouth 110

#### Select the Theme
sudo update-alternatives --config default.plymouth

#### Rebuild the initial Ramdisk:
sudo update-initramfs -u -k all

-------------------------------------------------------------------

### Debian/Arch Linux

#### Please look, if the theme "pulsar-plymouth" is recognized
sudo plymouth-set-default-theme -l

#### Apply the theme
sudo plymouth-set-default-theme -R pulsar-plymouth

-------------------------------------------------------------------

### Fedora

#### Please look, if the theme "pulsar-plymouth" is recognized
sudo plymouth-set-default-theme -l

#### Apply the theme
sudo plymouth-set-default-theme -R pulsar-plymouth

#### Rebuild the initrd

sudo dracut --regenerate-all -f

-------------------------------------------------------------------

## Source:  
Adapted from the original: [theme from pling](https://www.gnome-look.org/p/2112595/)
