#!/usr/bin/pwsh
#-------------------------
Import-Module "$env:pISHome/modules/newSymlink/newSymlink.psm1";
Import-Module "$env:pISHome/modules/extras.psm1";
$dotfilesLocation = "$HOME/.dotfiles/hyprland"; # Change here!
$configPath = "$HOME/.config";
$localPath = "$HOME/.local/share";
$appIcons = "$HOME/app-icons";
$date = Get-Date;

$ErrorActionPreference = "Stop";
do { Clear-Host; #* Starts the TUI loop
#-------------------------
$menuTitle = " Dotfile Manager ";
$options = @(
    " 1. Export dotfiles",
    " 2. Import dotfiles",
    " 3. Install dotfiles",
    " 4. Back",
    ""
);
& "$scriptPath/_dotExportList.ps1";
& "$scriptPath/_tui.ps1";

$actionTui = ([System.Console]::ReadKey($true)).KeyChar; # Read entry

switch ($actionTui) {
    1 { #* Exporting dotfiles 
        # Remember to: git remote set-url origin https://<Token>@github.com/<Username>/<Repo>
        if (!(Test-Path "$dotfilesLocation")) {
            New-Item -Path "$HOME" -Name ".dotfiles" -ItemType Directory
        }

        #-------------------------
        #Pay some attention here, you might want to change the ErrorAction preference. 
        $dotConfig | ForEach-Object {
            Copy-Item -Path "$configPath/$_" -Destination "$dotfilesLocation/config" -Recurse -Force -ErrorAction SilentlyContinue
        };

        $dotLocal | ForEach-Object {
            Copy-Item -Path "$localPath/$_" -Destination "$dotfilesLocation/local" -Recurse -Force -ErrorAction SilentlyContinue
        };

        $dotHome | ForEach-Object { 
            Copy-Item -Path "$HOME/$_" -Destination "$dotfilesLocation" -Force -ErrorAction SilentlyContinue
        };

        Copy-Item -Path "$appIcons" -Destination "$dotfilesLocation/nativefierApps/appIcons" -Recurse -Force -ErrorAction SilentlyContinue;
        #-------------------------
        
        try {
            Push-Location;
            cd $dotfilesLocation;
            git add .;
            git commit -m "Dotfiles from $date";
            git push -u origin main;
            Pop-Location;
            Pause;
        }
        catch {
            Write-Output "An error occurred while exporting dotfiles";
            $_;
            Pause;
            Continue;
        }
    }

    2 { #* Importing dotfiles
        $repositoryLink = (Read-Host "Enter the repository URL");
        $importLocation = (Read-Host "Enter the import location (default: $dotfilesLocation)");

        if ($importLocation -eq "") {
            $importLocation = $dotfilesLocation;
        }
        elseif (!(Test-Path $importLocation)) {
            New-Item -ItemType Directory -Path $importLocation;
        }
        
        try {
            irepo -Path "$repositoryLink" -Destination "$importLocation";
        }
        catch {
            Write-Output "An error occurred while importing dotfiles";
            $_;
            Pause;
            Continue;
        }
    }

    3 { #* Installation
        try {
            Write-Output "WARNING: This will overwrite your files. Do you want to continue? (y/n)";
            $continue = ([System.Console]::ReadKey($true)).KeyChar;
            if ($continue -eq "y") {
                slinkf -Path "$dotfilesLocation/config" -Destination "$HOME/.config" -NoConfirm;
                foreach ($file in $dotHome) {
                    Copy-Item -Path "$dotfilesLocation/$file" -Destination "$HOME" -Force;
                }

                foreach ($folder in $dotHome) {
                    Copy-Item -Path "$dotfilesLocation/local/share/$folder" -Destination "$localPath" -Force;
                }

                # $dotHome | ForEach-Object {
                #     (Copy-Item -Path "$dotfilesLocation/$_" -Destination "$HOME" -Force -ErrorAction SilentlyContinue)
                # };
                # $dotLocal | ForEach-Object {
                #     (Copy-Item -Path "$dotfilesLocation/local/share/$_" -Destination "$localPath" -Force -ErrorAction SilentlyContinue)
                # };
            } 
        }
        catch {
            Write-Output "An error occurred while installing dotfiles";
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
