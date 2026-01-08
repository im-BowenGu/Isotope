#!/bin/bash
# bootstrap.sh - The Isotope System Builder
set -e

echo "🌀 Initializing Isotope Build..."

# 1. Update and Install Core Hyprland/Wayland Stack
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm \
    hyprland waybar swaync rofi-lbonn-wayland-git \
    kitty swww hyprlock hypridle \
    network-manager-applet blueman pavucontrol nwg-look \
    xdg-desktop-portal-hyprland flatpak nix \
    ttf-jetbrains-mono-nerd ttf-font-awesome inter-font

# 2. Install AUR Helper (Paru)
if ! command -v paru &> /dev/null; then
    echo "📦 Installing Paru..."
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin && makepkg -si --noconfirm
    cd .. && rm -rf paru-bin
fi

# 3. Fetch Custom Tools from im-BowenGu GitHub
mkdir -p ~/Gateway && cd ~/Gateway
echo "🔧 Fetching ArchABRoot and NixMan..."
git clone https://github.com/im-BowenGu/ArchABRoot.git || true
git clone https://github.com/im-BowenGu/NixMan.git || true

# Install scripts to /usr/local/bin (Part of the System ROM)
sudo cp ArchABRoot/abroot.sh /usr/local/bin/abroot
sudo cp ArchABRoot/setup_config.sh /usr/local/bin/abroot-setup
sudo cp NixMan/nixman.sh /usr/local/bin/nixman
sudo chmod +x /usr/local/bin/abroot /usr/local/bin/abroot-setup /usr/local/bin/nixman

# 4. Install System Apps (ROM Layer)
echo "🖥️ Installing Native Apps..."
paru -S --noconfirm \
    zen-browser-bin spotube-bin \
    vscodium-bin zed-git neovim wl-clipboard

# 5. Initialize NixMan
echo "❄️ Setting up Nix..."
sudo systemctl enable --now nix-daemon.service
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update
nixman update

# 6. ML4W & Neovim Setup
echo "🎨 Fetching UI Dotfiles..."
git clone https://github.com/mylinuxforwork/dotfiles.git ~/ml4w-dotfiles || true
git clone https://github.com/LazyVim/starter ~/.config/nvim || true

echo "----------------------------------------------------"
echo "✅ Build complete."
echo "1. Run 'abroot-setup' to link your partitions."
echo "2. Run 'abroot upgrade' to clone this state to Slot B."
echo "3. Run 'cd ~/ml4w-dotfiles && ./install.sh' for the UI."
echo "----------------------------------------------------"
