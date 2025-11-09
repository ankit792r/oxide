echo "Preparing system..."

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed base-devel git curl wget unzip

success "System ready to install."
