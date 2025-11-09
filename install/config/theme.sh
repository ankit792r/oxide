# Setup theme links
mkdir -p ~/.config/oxide/themes
for f in $OXIDE_PATH/themes/*; do 
    ln -nfs "$f" ~/.config/oxide/themes/; 
done

# Set initial theme
mkdir -p ~/.config/oxide/current
ln -snf ~/.config/oxide/themes/tokyo-night ~/.config/oxide/current/theme
ln -snf ~/.config/oxide/current/theme/backgrounds/2-Pawel-Czerwinski-Abstract-Purple-Blue.jpg ~/.config/oxide/current/background
