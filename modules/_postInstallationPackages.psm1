<#
.SYNOPSIS
    Installs specific packages using the "yay" package manager on Arch Linux.

.DESCRIPTION
    The Install-PIPackages function allows you to install packages categorized into:
    - Basic
    - Utility
    - Hyprland
    - Appearance
    - Software
    - User-defined packages
    
    The packages are read from text files located in the "packages" folder within the script directory.

.PARAMETER Basic
    Installs basic packages listed in the "_basicPacks" file.

.PARAMETER Utility
    Installs utility packages listed in the "_utilityPacks" file.

.PARAMETER Hyprland
    Installs Hyprland-related packages as specified in the "_hyprPacks" file.

.PARAMETER Appearance
    Installs appearance customization packages listed in "_appearancePacks".

.PARAMETER Software
    Installs additional software specified in the "_softwarePacks" file.

.PARAMETER Path
    Installs user-defined packages from a custom file.

.EXAMPLE
    Install-PIPackages -Utility
    Installs only utility packages.

.EXAMPLE
    Install-PIPackages -Hyprland -Appearance
    Installs both Hyprland-related and appearance packages.

.NOTES
    - The script uses `yay` as the package manager.
    - Lines starting with `#` in package files are ignored.
    - If no parameters are provided, the function will not install any packages.

#>
function Install-PIPackages {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [switch]$Basic,

        [Parameter(Position = 1, Mandatory = $false)]
        [switch]$Utility,

        [Parameter(Position = 2, Mandatory = $false)]
        [switch]$Hyprland,

        [Parameter(Position = 3, Mandatory = $false)]
        [switch]$Appearance,

        [Parameter(Position = 4, Mandatory = $false)]
        [switch]$Software,

        [Parameter(Position = 5, Mandatory = $false)]
        [string]$Path
    )
    
    begin {
        $ErrorActionPreference = "Stop";
        try {
            # Basic
            $basicPacks = (Get-Content "$env:pISHome/packages/_basicPacks" | Where-Object { $_ -notmatch '^#' });

            # Utility
            $utilityPacks = (Get-Content "$env:pISHome/packages/_utilityPacks" | Where-Object { $_ -notmatch '^#' });

            # Hyprland
            $hyprPacks = (Get-Content "$env:pISHome/packages/_hyprPacks" | Where-Object { $_ -notmatch '^#' });

            # Appearances
            $appearancePacks = (Get-Content "$env:pISHome/packages/_appearancePacks" | Where-Object { $_ -notmatch '^#' });

            # Software
            $softwarePacks = (Get-Content "$env:pISHome/packages/_softwarePacks" | Where-Object { $_ -notmatch '^#' });
            

            # User-defined packages
            if ($Path) {
                $userPathPacks = (Get-Content "$Path" | Where-Object { $_ -notmatch '^#' });
            }
        }
        catch {
            Write-Output "Error reading package files: $_";
            continue;
        }      
    }
    
    process {
        try {
            switch ($PSCmdlet.MyInvocation.BoundParameters.Keys) {
                "Basic" {
                    yay -S --disable-download-timeout --noconfirm --quiet $($basicPacks);
                }
                "Utility" {
                    yay -S --disable-download-timeout --noconfirm --quiet $($utilityPacks);
                }
                "Hyprland" {
                    yay -S --disable-download-timeout --noconfirm --quiet $($hyprPacks);
                }
                "Appearance" {
                    yay -S --disable-download-timeout --noconfirm --quiet $($appearancePacks);
                }
                "Software" {
                    yay -S --disable-download-timeout --noconfirm --quiet $($softwarePacks);
                }
                "Path" {
                    yay -S --disable-download-timeout --noconfirm --quiet $($userPathPacks);
                }
                default {
                    Write-Output "No packages selected";
                }
            }
        }
        catch {
            Write-Output "Installation of $($_) packages failed: $_";
        }
    }
    
    end {
        if ($Error.Count -eq 0) {
            Write-Output "Packages installed successfully";
        }
    }
}

# If you want to use a wrapper function to call the Install-DotfilesPackages function, uncomment the following code
# function idpack {
#     param (
#         [switch]$Basic,
#         [switch]$Utility,
#         [switch]$Hyprland,
#         [switch]$Appearance,
#         [switch]$Software,
#         [string]$Path
#     )

#     Install-DotfilesPackages @PSBoundParameters
# }