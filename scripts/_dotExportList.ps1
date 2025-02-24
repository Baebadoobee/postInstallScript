#!/usr/bin/pwsh
#-------------------------
# Dotfile list
#-------------------------
# If you, just like me, want to add something more, feel free
$dotConfig = @( 
    "alacritty",
    "BetterDiscord",
    "btop",
    "cava",
    "hypr",
    "neofetch",
    "nwg-dock-hyprland",
    "nwg-look",
    "powershell",
    "swaync",
    "Thunar",
    "wal",
    "waybar",
    "waypaper",
    "wlogout",
    "wofi"
);

$dotLocal = @( 
    "applications",
    'CipSoft GmbH',
    "powershell"
);

$dotHome = @(
    ".vimrc",
    ".bashrc"
);
#-------------------------
if (-not (Test-Path "$dotfilesLocation")) {
    New-Item -Path "$HOME" -Name ".dotfiles" -ItemType Directory
}

$dotConfig | ForEach-Object {
    Copy-Item -Path "$configPath/$_" -Destination "$dotfilesLocation/hyprland/config" -Recurse -Force
};

$dotLocal | ForEach-Object {
    Copy-Item -Path "$localPath/$_" -Destination "$dotfilesLocation/hyprland/local" -Recurse -Force
};

$dotHome | ForEach-Object { 
    Copy-Item -Path "$HOME/$_" -Destination "$dotfilesLocation/hyprland/" -Force
};

Copy-Item -Path "$appIcons" -Destination "$dotfilesLocation/hyprland/nativefierApps/appIcons" -Recurse -Force;

