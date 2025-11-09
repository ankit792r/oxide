#!/usr/bin/env bash
# ============================================
# Hyprland Modular Setup Script for Arch Linux
# ============================================

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

export OXIDE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export OXIDE_INSTALL="$OXIDE_PATH/install"
export PATH="$OXIDE_PATH/bin:$PATH"

source "$OXIDE_INSTALL/helpers/all.sh"
source "$OXIDE_INSTALL/package/all.sh"
source "$OXIDE_INSTALL/config/all.sh"
source "$OXIDE_INSTALL/post-install/finish.sh"


