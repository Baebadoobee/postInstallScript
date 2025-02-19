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
        try {
            Write-Output "WARNING: This might take a while, do you still want to continue? (y/n)";
            $continue = (([System.Console]::ReadKey($true)) | Select-Object KeyChar).KeyChar;
            if ($continue -eq "y") {
                idpack -Utility -Hyprland -Appearance -Software;
            }
            else {
                Write-Output "Installation aborted";
                Start-Sleep -Seconds 2;
                Continue;
            }
        }
        catch {
            Write-Output "An error occurred while installing all packages";
            $_;
            Continue;
        }  
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
                        Write-Output "Invalid package group: $packageGroup";
                        exit;
                    }
                } 
            }
            catch {
                Write-Output "Error installing package group: $packageGroup";
                $_.Exception.Message;
                Continue;
            }
        }
    }

    3 { # Open the dotfile manager
        try {
            & $PSScriptRoot/modules/_dotfilesManager.ps1;
        }
        catch {
            Write-Output "An error occurred while opening the dotfile manager";
            $_;
            Continue;
        }
    }

    4 { #* Quit
        exit;
    }
}

#-------------------------
} while ($true)
#-------------------------