#!/usr/bin/env bash
# ==============================================================================
# Hyprland NVIDIA Setup Script for Arch Linux
# ==============================================================================
# Author: https://github.com/Kn0ax
# ==============================================================================

# --- GPU Detection ---
if lspci | grep -iq 'nvidia'; then

  # --- Driver Selection ---
  if lspci | grep -i 'nvidia' | grep -qE 'RTX (1[6-9]|[23456789][0-9]{2,})|GTX 16'; then
    NVIDIA_DRIVER_PACKAGE="nvidia-open-dkms"
  else
    NVIDIA_DRIVER_PACKAGE="nvidia-dkms"
  fi

  # --- Kernel Header Detection ---
  KERNEL=$(uname -r)
  case "$KERNEL" in
    *zen*) KERNEL_HEADERS="linux-zen-headers" ;;
    *lts*) KERNEL_HEADERS="linux-lts-headers" ;;
    *hardened*) KERNEL_HEADERS="linux-hardened-headers" ;;
    *) KERNEL_HEADERS="linux-headers" ;;
  esac

  # --- Update system ---
  sudo pacman -Syu --noconfirm

  # --- Install packages ---
  PACKAGES_TO_INSTALL=(
    "$KERNEL_HEADERS"
    "$NVIDIA_DRIVER_PACKAGE"
    "nvidia-utils"
    "lib32-nvidia-utils"
    "egl-wayland"
    "libva-nvidia-driver"
    "qt5-wayland"
    "qt6-wayland"
  )
  sudo pacman -S --needed --noconfirm "${PACKAGES_TO_INSTALL[@]}"

  # --- Configure modprobe ---
  echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf >/dev/null

  # --- Configure mkinitcpio ---
  MKINITCPIO_CONF="/etc/mkinitcpio.conf"
  NVIDIA_MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
  sudo cp "$MKINITCPIO_CONF" "${MKINITCPIO_CONF}.backup"
  sudo sed -i -E "/^MODULES=/c\MODULES=(${NVIDIA_MODULES})" "$MKINITCPIO_CONF"
  sudo mkinitcpio -P

  # --- Hyprland NVIDIA Env Vars ---
  HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"
  if [ -f "$HYPRLAND_CONF" ] && ! grep -q "NVD_BACKEND" "$HYPRLAND_CONF"; then
    cat >>"$HYPRLAND_CONF" <<'EOF'

# NVIDIA environment variables
env = NVD_BACKEND,direct
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
env = WLR_RENDERER_ALLOW_SOFTWARE,1
EOF
  fi
fi
