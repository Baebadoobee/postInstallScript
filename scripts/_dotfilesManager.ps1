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
& "$scriptPath/_tui.ps1";

$actionTui = ([System.Console]::ReadKey($true)).KeyChar; # Read entry

switch ($actionTui) {
    1 { 
        # Remember to: git remote set-url origin https://<Token>@github.com/<Username>/<Repo>
        #* Exporting dotfiles

        & "$scriptPath/_dotExportList.ps1"
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

    2 {
        #* Importing dotfiles
        $repositoryLink = (Read-Host "Enter the repository URL");
        $importLocation = (Read-Host "Enter the import location (default: $dotfilesLocation)");

        if ($importLocation -eq "") {
            $importLocation = $dotfilesLocation;
        }
        elseif (-not (Test-Path $importLocation)) {
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

    3 {
        #* Installation
        try {
            # Config folder
            slinkf -Path "$dotfilesLocation/config" -Destination "$HOME/.config";

            # Neofetch
            sudo mv -f neofetch /bin/neofetch;
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
