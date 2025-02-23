#!/usr/bin/pwsh
#-------------------------
$env:pISHome = "$($PSScriptRoot)";
Import-Module "$env:pISHome/modules/postInstallationPackages/postInstallationPackages.psm1";
Import-Module "$env:pISHome/modules/extras.psm1";
New-Alias -Name expack -Value Export-Packlist -Description "Exports a packagelist." -Force;
New-Alias -Name irepo -Value Import-Repository -Description "Imports a git repository." -Force;
$scriptPath = "$env:pISHome/scripts";
$packagesPath = "$env:pISHome/packages";
$packageList = "$packagesPath/_packlist"; #* Default package list

$ErrorActionPreference = "Stop";
do { Clear-Host; #* Starts the TUI loop
#-------------------------
$menuTitle = " Post-installation Manager ";
$options = @(
    " 1. Install package list",
    " 2. Select separated package lists",
    " 3. Export package list",
    " 4. Open dotfile manager",
    " 5. Quit"
);
& "$scriptPath/_tui.ps1";

$actionTui = ([System.Console]::ReadKey($true)).KeyChar; # Read entry

switch ($actionTui) {
    1 { # Installs all packages
        try {
            Write-Output "WARNING: This might take a while, do you still want to continue? (y/n)";
            $continue = ([System.Console]::ReadKey($true)).KeyChar;
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

    2 { # Select package groups
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

    3 { # Export package list
        try {
            Write-Output "Do you want to export a new packlist? (y/n)";
            $continue = ([System.Console]::ReadKey($true)).KeyChar;
            if ($continue -eq "y") {
                expack -Path "$packageList";
            }
            else {
                Write-Output "Exportation aborted";
                Start-Sleep -Seconds 2;
                Continue;
            }
        }
        catch {
            Write-Output "Export failed";
            $_;
            Pause;
            Continue;
        }
    }

    4 { # Open the dotfile manager
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

    5 { # Quit
        exit;
    }
}

#-------------------------
} while ($true)
#-------------------------
