echo "Installing extras..."

PKG_FILE="$OXIDE_INSTALL/extra.packages"
if [[ ! -f "$PKG_FILE" ]]; then
  echo "No extra packages found, skipping..."
  exit 0
fi

PKGS=$(grep -vE '^\s*#' "$PKG_FILE" | grep -vE '^\s*$')
sudo pacman -S --needed $PKGS

echo "Extra packages installed."