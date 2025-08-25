#!/bin/bash

set -e  # Exit on error

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

echo -e "${BLUE}Starting dotfiles installation...${NC}"
echo -e "${BLUE}Dotfiles directory: $DOTFILES_DIR${NC}"

create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    local target_dir="$(dirname "$target")"
    if [[ ! -d "$target_dir" ]]; then
        echo -e "${YELLOW}Creating directory: $target_dir${NC}"
        mkdir -p "$target_dir"
    fi
    
    # If target already exists
    if [[ -e "$target" || -L "$target" ]]; then
        # If it's already the correct symlink, skip
        if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
            echo -e "${GREEN}✓${NC} $target already linked correctly"
            return 0
        fi
        
        # Create backup
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}Backing up existing file: $target -> $backup${NC}"
        mv "$target" "$backup"
    fi
    
    # Create the symlink
    echo -e "${GREEN}Linking:${NC} $target -> $source"
    ln -s "$source" "$target"
}

link_config_dir() {
    local config_name="$1"
    local source_dir="$DOTFILES_DIR/$config_name"
    local target_dir="$HOME/.config/$config_name"
    
    if [[ -d "$source_dir" ]]; then
        echo -e "${BLUE}Processing config directory: $config_name${NC}"
        create_symlink "$source_dir" "$target_dir"
    fi
}

mkdir -p "$HOME/.config"

echo -e "\n${BLUE}Creating symlinks...${NC}"


for item in "$DOTFILES_DIR"/.??* "$DOTFILES_DIR"/*; do
    # Skip if item doesn't exist (handles case where no matches found)
    [[ -e "$item" ]] || continue
    
    filename="$(basename "$item")"
    
    if [[ -f "$item" ]]; then
        # Handle dotfiles (not directories)
        if [[ "$filename" == .* ]]; then
            # Skip special dotfiles
            case "$filename" in
                ".gitignore"|".DS_Store")
                    echo -e "${YELLOW}Skipping: $filename${NC}"
                    continue
                    ;;
                *)
                    echo -e "${GREEN}Processing dotfile: $filename${NC}"
                    create_symlink "$item" "$HOME/$filename"
                    ;;
            esac
        fi
    elif [[ -d "$item" ]]; then
        # Handle directories
        if [[ "$filename" != .* ]]; then  # Skip hidden directories like .git
            # Skip special directories and files
            case "$filename" in
                "tmux")
                    echo -e "${YELLOW}Skipping special directory: $filename${NC}"
                    continue
                    ;;
                *)
                    link_config_dir "$filename"
                    ;;
            esac
        fi
    fi
done

if [[ -f "$DOTFILES_DIR/tmux/tmux.conf" ]]; then
    echo -e "${BLUE}Processing tmux configuration...${NC}"
    create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
fi

echo -e "\n${GREEN}✓ Dotfiles installation complete!${NC}"
