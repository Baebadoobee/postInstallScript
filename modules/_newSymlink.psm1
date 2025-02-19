<#
.SYNOPSIS
Creates symbolic links for files within a specified directory.

.DESCRIPTION
The New-Symlink function creates symbolic links for all files in the specified source directory ($Path) and links them to the specified destination directory ($Destination). 
If the destination directory does not exist, it will be created.

.PARAMETER Path
The source directory containing the files to be linked. This must be an existing directory.

.PARAMETER Destination
The target directory where the symbolic links will be created. If the directory does not exist, it will be created.

.PARAMETER NoConfirm
A switch parameter that, when specified, bypasses the confirmation prompt before creating the symbolic links.

.EXAMPLE
New-Symlink -Path "$HOME/folder1" -Destination "$HOME/folder2"

Creates symbolic links for all files in "$HOME/folder1" and places them in "$HOME/folder2".

.EXAMPLE
New-Symlink -Path "C:\Configs" -Destination "D:\Symlinks" -NoConfirm

Creates symbolic links without asking for confirmation.

.NOTES
- Ensure you have the necessary permissions to create symbolic links.
- Running PowerShell as an administrator may be required.
- If a symbolic link already exists, it will be replaced.

#>

function New-Symlink {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$Path,

        [Parameter(Position = 1, Mandatory = $true)]
        [string]$Destination,

        [Parameter(Position = 2, Mandatory = $false)]
        [switch]$NoConfirm
    )
    
    begin {
        $ErrorActionPreference = "Stop";

        if (-not (Test-Path $Path)){
            Write-Output "The path $Path does not exist";
            break;
        }
    }
    
    process {
        $origin = (Get-ChildItem -Path $Path);
        $linkConfirm = "y";

        #.config folder files
        if (-not ($NoConfirm)) {
            $linkConfirm = Read-Host "Link files $($Path) to $($Destination)? (y/n)";
        }

        if ($linkConfirm -eq "y") {
            if (-not (Test-Path $Destination)) {
                Write-Output "Creating $Destination";
                New-Item -ItemType Directory -Path $Destination;
            }

            foreach ($folder in $origin) {
                try {
                    $folderName = $folder.Name;
                    $folderPath = $folder.FullName;
                    Write-Output "Creating symlink for $Name";
                    New-Item -Path $Destination -Name $folderName -ItemType SymbolicLink -Value $folderPath -Force;
                }
                catch {
                    Write-Output "Symlink creation failed for $folderName";
                    $_;
                }
            }
        }

        else {
            Write-Output "Skipping linking $Path files to $Destination";
        }
   }
}

# If you want to use a wrapper function to call the New-Symlink function, uncomment the following code
# function slinkf {
#     param (
#         [string]$Path,
#         [string]$Destination,
#         [switch]$NoConfirm
#     )
#
#     New-Symlink @PSBoundParameters
# }