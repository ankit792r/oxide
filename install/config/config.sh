SOURCE_CONFIG_DIR="$OXIDE_PATH/configs"
TARGET_CONFIG_DIR="$HOME/.config"

mkdir -p "$TARGET_CONFIG_DIR"

info "Linking configs"

for dir in "$SOURCE_CONFIG_DIR"/*; do
    target="$TARGET_CONFIG_DIR/$name"

    ln -sf "$dir" "$target"
    success "Linked $name → ~/.config/$name"
done

success "All configs linked!"