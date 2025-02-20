#!/usr/bin/pwsh
# All the modules are free to use and modify as you see fit.
#-------------------------
Import-Module "$PSScriptRoot/modules/postInstallationPackages/postInstallationPackages.psm1";

$env:pISHome = "$($PSScriptRoot)";
$scriptPath = "$env:pISHome/scripts"
$packagesPath = "$env:pISHome/packages";
$packageList = "$packagesPath/_packlist"; #* Default package list

#-------------------------
# Post installation script
#-------------------------
$ErrorActionPreference = "Stop";
do { Clear-Host; #* Starts the TUI loop

$menuTitle = " Post-installation Manager ";
$options = @(
    " 1. Install package list"
    " 2. Select separated package lists"
    " 3. Open dotfile manager"
    " 4. Quit"
)
& "$scriptPath/_tui.ps1";

# Read entry
$actionTui = (([System.Console]::ReadKey($true)) | Select-Object KeyChar).KeyChar;
#-------------------------

switch ($actionTui) {
    1 { #* Installs all packages
        try {
            Write-Output "WARNING: This might take a while, do you still want to continue? (y/n)";
            $continue = (([System.Console]::ReadKey($true)) | Select-Object KeyChar).KeyChar;
            if ($continue -eq "y") {
                pipack $packageList;
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
            Pause;
            Continue;
        }  
    }

    2 { #* Select package groups
        $packageGroups = Read-Host "Enter package group names to install (default path: $packagesPath)";

        foreach ($packageGroup in $packageGroups.Split(" ")) {
            try {
                pipack -Path "$packagesPath/_$packageGroup"; # List by file
            }
            catch {
                Write-Output "Error installing package group: $packageGroup";
                $_.Exception.Message;
                Pause;
                Continue;
            }
        }
    }

    3 { # Open the dotfile manager
        try {
            & "$scriptPath/_dotfilesManager.ps1";
        }
        catch {
            Write-Output "An error occurred while opening the dotfile manager";
            $_;
            Pause;
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