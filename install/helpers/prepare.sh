echo "Preparing system..."

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed base-devel git curl wget unzip

echo "System ready to install."
