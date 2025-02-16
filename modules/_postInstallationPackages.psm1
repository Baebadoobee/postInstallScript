<#
.SYNOPSIS
    Installs specific packages using the "yay" package manager on Arch Linux.

.DESCRIPTION
    The Install-Packages function allows you to install packages categorized into:
    - Utility
    - Hyprland
    - Appearance
    - Software
    
    The packages are read from text files located in the "packages" folder within the script directory.

.PARAMETER Utility
    Installs utility packages listed in the "_utilityPacks" file.

.PARAMETER Hyprland
    Installs Hyprland-related packages as specified in the "_hyprPacks" file.

.PARAMETER Appearance
    Installs appearance customization packages listed in "_appearancePacks".

.PARAMETER Software
    Installs additional software specified in the "_softwarePacks" file.

.EXAMPLE
    Install-Packages -Utility
    Installs only utility packages.

.EXAMPLE
    Install-Packages -Hyprland -Appearance
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
        [switch]$Utility,

        [Parameter(Position = 1, Mandatory = $false)]
        [switch]$Hyprland,

        [Parameter(Position = 2, Mandatory = $false)]
        [switch]$Appearance,

        [Parameter(Position = 3, Mandatory = $false)]
        [switch]$Software
    )
    
    begin {
        $ErrorActionPreference = "Stop";
        try {
            # Utility
            $utilityPacks = (Get-Content "$env:pISHome/packages/_utilityPacks" | Where-Object { $_ -notmatch '^#' });

            # Hyprland
            $hyprPacks = (Get-Content "$env:pISHome/packages/_hyprPacks" | Where-Object { $_ -notmatch '^#' });

            # Appearances
            $appearancePacks = (Get-Content "$env:pISHome/packages/_appearancePacks" | Where-Object { $_ -notmatch '^#' });

            # Software
            $softwarePacks = (Get-Content "$env:pISHome/packages/_softwarePacks" | Where-Object { $_ -notmatch '^#' });
        }
        catch {
            Write-Output "Error reading package files: $_";
            continue;
        }      
    }
    
    process {
        try {
            switch ($PSCmdlet.MyInvocation.BoundParameters.Keys) {
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
#         [switch]$Utility,
#         [switch]$Hyprland,
#         [switch]$Appearance,
#         [switch]$Software
#     )

#     Install-DotfilesPackages @PSBoundParameters
# }