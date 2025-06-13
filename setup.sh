#!/bin/bash

# Ensure the script is being run as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

# Constants
USER_HOME=$(eval echo ~"${SUDO_USER:-$USER}")

echo "Copying user dotfiles to $USER_HOME..."

# Home files
cp ./dotfiles/tmux.conf "$USER_HOME/.tmux.conf"
cp ./dotfiles/vimrc "$USER_HOME/.vimrc"
cp ./dotfiles/zshrc "$USER_HOME/.zshrc"

cp -r ./config/ncspot "$USER_HOME/ncspot"
cp -r ./config/vim "$USER_HOME/vim"
cp -r ./config/zsh "$USER_HOME/zsh"

chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.tmux.conf" "$USER_HOME/.vimrc" "$USER_HOME/.zshrc" \
  "$USER_HOME/ncspot" "$USER_HOME/vim" "$USER_HOME/zsh"

# Local system-wide files
mkdir -p /usr/local/bin
cp ./local/bin/vm /usr/local/bin/vm

chmod +x /usr/local/bin/*

mkdir -p /usr/local/lib
cp -r ./local/lib/llama /usr/local/lib/llama
cp -r ./local/lib/vm /usr/local/lib/vm

chmod +x /usr/local/lib/llama/*
chmod +x /usr/local/lib/vm/*

# Skel for new users
echo "Populating /etc/skel/..."
cp ./dotfiles/tmux.conf /etc/skel/.tmux.conf
cp ./dotfiles/vimrc /etc/skel/.vimrc
cp ./dotfiles/zshrc /etc/skel/.zshrc

mkdir -p /etc/skel/.config
cp -r ./config/ncspot /etc/skel/.config/ncspot
cp -r ./config/vim /etc/skel/.config/vim
cp -r ./config/zsh /etc/skel/.config/zsh

# System packages
echo "Installing system packages..."
pacman -Syu --needed --noconfirm \
  make cmake gcc cuda \
  wget curl \
  usbutils pciutils \
  man-db man-pages \
  zip unzip tar file lsof \
  git tree \
  rsync wl-clipboard \
  btop openssh \
  tmux gvim neovim zsh foot \
  pkgconf \
  python \
  jq ripgrep fzf \
  inetutils iproute2 iputils net-tools \
  nvidia nvidia-utils nvidia-settings nvidia-open nvidia-prime \
  chromium firefox libreoffice \
  pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber alsa-utils

modprobe nvidia || echo "modprobe nvidia failed, check kernel modules"
-u "$SUDO_USER" systemctl --user enable --now pipewire pipewire-pulse wireplumber
-u "$SUDO_USER" systemctl --user mask pulseaudio.service pulseaudio.socket

# yay AUR helper
echo "Installing yay..."
if ! command -v yay >/dev/null 2>&1; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay &&
  chown -R "$SUDO_USER:$SUDO_USER" /tmp/yay &&
  cd /tmp/yay &&
  sudo -u "$SUDO_USER" makepkg -si --noconfirm || echo "Yay couldn't be installed"

  rm -rf /tmp/yay
else
  echo "yay is already installed."
fi

# Backup grub config before editing
cp /etc/default/grub /etc/default/grub.bak

# Use sed to update or add nvidia_drm.modeset=1 to GRUB_CMDLINE_LINUX_DEFAULT
if grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=' /etc/default/grub; then
  # Append or replace existing nvidia_drm.modeset option
  sed -i -E 's/^(GRUB_CMDLINE_LINUX_DEFAULT=")([^"]*)(")/\1\2 nvidia_drm.modeset=1\3/' /etc/default/grub
else
  # Add the line if it doesn't exist (very rare)
  echo 'GRUB_CMDLINE_LINUX_DEFAULT="nvidia_drm.modeset=1"' >> /etc/default/grub
fi

echo "Updated /etc/default/grub with nvidia_drm.modeset=1"

# Regenerate grub config (important to apply the change)
if [ -x "$(command -v grub-mkconfig)" ]; then
  grub-mkconfig -o /boot/grub/grub.cfg
  echo "Grub config regenerated."
else
  echo "Warning: grub-mkconfig not found. Please update grub config manually."
fi
