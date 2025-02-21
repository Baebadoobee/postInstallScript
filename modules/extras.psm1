function Export-Packlist ([string]$Path) {
    pacman -Q > $Path;
    
    $index = 0;
    @(Get-Content $Path).Split(" ") | Where-Object {
        ((++$index % 2) -ne 0)
    } | 
    Out-File -Path $Path;
}

function Import-Repository ([string]$Path, [string]$Destination) {
    git clone $Path $Destination;
}

<#
.SYNOPSIS
Retrieves and displays the package dependency tree for installed packages using `pactree`.

.DESCRIPTION
The `Get-PackTree` function extracts installed packages using `pacman -Q`, then processes each package 
through `pactree` to generate its dependency tree. The output is saved to a specified file and displayed.

.PARAMETER Depth
Specifies the depth level for the dependency tree. If not provided, defaults to 0 (full depth).

.PARAMETER Path
Specifies the file path where the package list will be saved. Defaults to "$HOME/pactree" if not provided.

.EXAMPLE
PS> Get-PackTree -Depth 2
Generates a package dependency tree up to a depth of 2 and saves the package list to "$HOME/pactree".

.EXAMPLE
PS> Get-PackTree -Depth 1 -Path "C:\temp\packages.txt"
Generates a package dependency tree up to a depth of 1 and saves the package list to "C:\temp\packages.txt".

.NOTES
- Requires `pacman` and `pactree` to be available in the system.
- If the command fails, an error message is displayed.
#>
function Get-PackTree {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [int]$Depth, 

        [Parameter(Position = 1, Mandatory = $false)]
        [string]$Path
    )

    begin {
        $ErrorActionPreference = 'Stop';

        $index = 0;

        if (-not ($Path)) {
            $Path = "$HOME/pactree";
        }
        elseif (-not ($Depth)) {
            $Depth = 0;
        }
            
    }

    process {
        try {
            pacman -Q > $Path;
            @(Get-Content $Path).Split(" ") | Where-Object {
                ((++$index % 2) -ne 0)
            }| 
            ForEach-Object {
                (pactree --depth $Depth $_)
            };
        }
        catch {
            Write-Output "Failed to get package tree.";
            $_;
            Pause;
        }
    }
}

Export-ModuleMember -Function Export-Packlist;
Export-ModuleMember -Function Get-PackTree;
Export-ModuleMember -Function Import-Repository;