#!/usr/bin/pwsh
# remember to: git remote set-url origin https://<Token>@github.com/<Username>/<Repo>
# Install-Module -Name GitAutomation;

Import-Module "$env:pISHome/modules/_newSymlink.psm1";
# Import-Module GitAutomation;

function Import-Repository ([string]$Path, [string]$Destination) {
    git clone $Path $Destination;
}

New-Alias -Name slinkf -Value New-Symlink -Description "Creates symbolic links for files within a specified directory." -Force;
New-Alias -Name irepo -Value Import-Repository -Description "Imports a repository from an upstream link." -Force;

$dotfilesLocation = "$HOME/.dotfiles";
$date = Get-Date;

#-------------------------
$ErrorActionPreference = "Stop";
do { Clear-Host; #* Starts the TUI loop
& $env:pISHome/modules/_tuiDotmgr.ps1;

# Read entry
$actionTui = (([System.Console]::ReadKey($true)) | Select-Object KeyChar).KeyChar;
#-------------------------
switch ($actionTui) {
    1 { 
        #* Exporting dotfiles
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
            Continue;
        }
    }

    2 {
        #* Importing dotfiles
        $repositoryLink = (Read-Host "Enter the repository URL");
        $importLocation = (Read-Host "Enter the import location (default: $dotfilesLocation)");

        if (-not (Test-Path $importLocation)) {
            New-Item -ItemType Directory -Path $importLocation;
        }
        elseif ($importLocation -eq "") {
            $importLocation = $dotfilesLocation;
        }

        try {
            irepo -Path $repositoryLink -Destination $importLocation;
        }
        catch {
            Write-Output "An error occurred while importing dotfiles";
            $_;
            Continue;
        }
    }

    3 {
        #* Installation
        try {
            # Config folder
            slinkf -Path "$dotfilesLocation/hyprland/config" -Destination"$HOME/.config";

            # Local folder
            slinkf -Path "$dotfilesLocation/hyprland/local/share" -Destination "$HOME/.local";

            # Neofetch
            sudo mv -f neofetch /bin;
        }
        catch {
            Write-Output "An error occurred while installing dotfiles";
            $_;
            Continue;
        }
    }

    4 { #* Quit
        exit;
    }
}
}
while ($true)

