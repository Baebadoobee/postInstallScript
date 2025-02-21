<#
.SYNOPSIS
    Installs packages using Yay from a list provided in a file.

.DESCRIPTION
    The Install-PIPackages function reads a list of packages from a specified file and installs them using Yay.
    Lines starting with '#' are ignored as comments.

.PARAMETER Path
    Specifies the path to the file containing the package list.
    Each package should be listed on a new line.

.EXAMPLE
    Install-PIPackages -Path "$HOME/packlists/exempleList"

    This command reads the package names from "exempleList" and installs them using Yay.

.NOTES
    - Requires Yay to be installed and available in the system PATH.
    - Packages are installed using Yay with the flags:
      --disable-download-timeout, --noconfirm, --needed.
    - Any errors encountered while reading the file or installing packages will be displayed.
    - If the installation is successful, a confirmation message is shown.
#>

function Install-PIPackages {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$Path,
        [Parameter(Position = 1, Mandatory = $false)]
        [switch]$All
    )
    
    begin {
        $ErrorActionPreference = "Stop";
        try {
            if ($All) {
                $packageList = (Get-Content "$Path" | Where-Object { 
                    ($_ -notmatch '^#') 
                }); 
                $packCount = $packageList.Count;
                Write-Output "Installing $packCount packages";
            }   
            else {
                $packageList = (Get-Content "$Path" | Where-Object { 
                    ($_ -notmatch '^#') -and ($_ -notmatch 'debug') 
                }); 
                $packCount = $packageList.Count;
                Write-Output "Installing $packCount packages";
            }       
        }
        catch {
            Write-Output "Error reading package file: $_";
            continue;
        }      
    }
    
    process {
        try {
            if ($Path) { #Foreach
                foreach ($package in $packageList) { # This way, progress lost is prevented
                    yay -S --disable-download-timeout --noconfirm --needed $($package);
                }
            }
            else {
                Write-Output "No packages selected";
            }
        }
        catch {
            Write-Output "Installation of $($_) packages failed: $_";
            Pause;
        }
    }
    
    end {
        if ($Error.Count -eq 0) {
            Write-Output "Packages installed successfully";
        }
    }
}

# Wrapper function
function pipack {
    param ([string]$Path)
    Install-PIPackages @PSBoundParameters;
}

Export-ModuleMember -Function Install-PIPackages;
Export-ModuleMember -Function pipack;
