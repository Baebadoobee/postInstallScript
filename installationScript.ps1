#!/usr/bin/pwsh
# All the modules are free to use and modify as you see fit.
#-------------------------
Import-Module "$PSScriptRoot/modules/_postInstallationPackages.psm1";

# You can call the function with the following alias:
New-Alias -Name idpack -Value Install-PIPackages -Description "Installs post installation packages" -Force;
$env:pISHome = "$($PSScriptRoot)";

#-------------------------
# Post installation script
#-------------------------
$ErrorActionPreference = "Stop";
do { Clear-Host; #* Starts the TUI loop
& $PSScriptRoot/modules/_tui.ps1;

# Read entry
$actionTui = (([System.Console]::ReadKey($true)) | Select-Object KeyChar).KeyChar;
#-------------------------

switch ($actionTui) {
    1 { #* Installs all packages
        idpack -Utility -Hyprland -Appearance -Software;
    }
    2 { #* Select package groups
        $packageGroups = Read-Host "Enter package groups to install (Utility, Appearance, Hyprland and Software)"

        foreach ($packageGroup in $packageGroups.Split(" ")) {
            try {
                switch ($packageGroup) {
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