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

Export-ModuleMember -Function Export-Packlist;
Export-ModuleMember -Function Import-Repository;
