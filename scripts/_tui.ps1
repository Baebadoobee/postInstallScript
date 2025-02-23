$width = [System.Console]::WindowWidth;
$menuHeader = "─" * ($width - 2);
$fileExt = ".ps1 ";
$combinedLength = $fileExt.Length + $menuTitle.Length + 2;
$widthInnerMenu = $width - 2;

# Title
[System.Console]::WriteLine("┌$menuHeader┐")
[System.Console]::WriteLine("│" + $menuTitle + " " * ($width - $combinedLength) + $fileExt + "│")
[System.Console]::WriteLine("├$menuHeader┤")

# Body
[System.Console]::WriteLine("│" + " " * ($width - 2) + "│")
foreach ($option in $options){
    [System.Console]::WriteLine("│" + $option + " " * ($widthInnerMenu - $option.Length) + "│")
}
[System.Console]::WriteLine("│" + " " * ($width - 2) + "│")
[System.Console]::WriteLine("└$menuHeader┘")
Write-Host "";
