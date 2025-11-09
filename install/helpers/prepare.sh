info "Preparing system..."
gum spin --spinner dot --title "Updating system and installing essentials..." -- \
  sudo pacman -Syu --noconfirm && \
  sudo pacman -S --noconfirm --needed base-devel git curl wget unzip gum

success "System ready to install."
