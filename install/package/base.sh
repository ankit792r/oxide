echo "Installing base packages..."

PKG_FILE="$OXIDE_INSTALL/base.packages"
if [[ ! -f "$PKG_FILE" ]]; then
  echo "base.packages file not found!"
  exit 1
fi

PKGS=$(grep -vE '^\s*#' "$PKG_FILE" | grep -vE '^\s*$')
sudo pacman -S --needed $PKGS

sudo systemctl enable --now NetworkManager bluetooth
echo "Base packages installed."
