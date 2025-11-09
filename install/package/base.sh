info "Installing base packages..."

PKG_FILE="$OXIDE_INSTALL/base.packages"
if [[ ! -f "$PKG_FILE" ]]; then
  error "base.packages file not found!"
  exit 1
fi

PKGS=$(grep -vE '^\s*#' "$PKG_FILE" | grep -vE '^\s*$')
gum spin --spinner line --title "Installing base packages..." -- sudo pacman -S --noconfirm --needed $PKGS

sudo systemctl enable --now NetworkManager bluetooth
success "Base packages installed."
