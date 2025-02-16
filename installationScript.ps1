#!/usr/bin/pwsh
# All the modules are free to use and modify as you see fit.
#-------------------------
Import-Module "$PSScriptRoot/modules/_installDotfilesPackages.psm1";

# You can call the function with the following alias:
New-Alias -Name idpack -Value Install-DotfilesPackages -Description "Installs dotfiles packages" -Force;

#-------------------------
# Post installation script
#-------------------------
$ErrorActionPreference = "Stop";
do { Clear-Host; #* Starts the TUI loop
#-------------------------

$width = [System.Console]::WindowWidth;
$menuHeader = "-" * ($width - 2);
$fileExt = ".ps1 ";
$menuTitle = " Bae's post installation script ";
$combinedLength = $fileExt.Length + $menuTitle.Length + 2;
$widthInnerMenu = $width - 2;
$options = @(
    " 1. Install all packages"
    " 2. Select package groups"
    " 3. Quit"
)

# $padding = [math]::Max(0, $width - $combinedLength);

#-------------------------
# TUI
#-------------------------

# Title
[System.Console]::WriteLine("+$menuHeader+")
[System.Console]::WriteLine("|" + $menuTitle + " " * ($width - $combinedLength) + $fileExt + "|")
[System.Console]::WriteLine("+$menuHeader+")

# Body
[System.Console]::WriteLine("|" + " " * ($width - 2) + "|")
foreach ($option in $options){
    [System.Console]::WriteLine("|" + $option + " " * ($widthInnerMenu - $option.Length) + "|")
}
[System.Console]::WriteLine("|" + " " * ($width - 2) + "|")
[System.Console]::WriteLine("+$menuHeader+")

# Read entry
Write-Host "";
$actionTui = (([System.Console]::ReadKey($true)) | Select-Object KeyChar).KeyChar;

#-------------------------
# Script
#-------------------------

switch ($actionTui) {
    1 { #* Installs all packages
        idpack -Utility -Hyprland -Appearance -Software;
    }
    2 { #* Select package groups
        $packageGroups = Read-Host "Enter package groups to install (Utility, Appearance, Hyprland and Software)"

        foreach ($packageGroup in $packageGroups.Split(" ")) {
            try {
                switch ($_) {
                    "utility" {  
                        idpack -Utility;
                    }
                    "appearance" {
                        idpack -Appearance;
                    }
                    "hyprland" { 
                        idpack -Hyprland;
                    }
                    "software" { 
                        idpack -Software;
                    }
                    Default { 
                        Write-Host "Invalid package group: $packageGroup";
                        exit;
                    }
                } 
            }
            catch {
                Write-Host "Error installing package group: $packageGroup";
                $_.Exception.Message;
            }
        }
    }
    3 { #* Quit
        exit;
    }
}

#-------------------------
} while ($true)
#-------------------------