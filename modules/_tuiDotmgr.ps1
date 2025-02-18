$width = [System.Console]::WindowWidth;
$menuHeader = "-" * ($width - 2);
$fileExt = ".ps1 ";
$menuTitle = " Doftiles Manager ";
$combinedLength = $fileExt.Length + $menuTitle.Length + 2;
$widthInnerMenu = $width - 2;
$options = @(
    " 1. Export dotfiles"
    " 2. Import dotfiles"
    " 3. Install dotfiles"
    " 4. Back"
)

# $padding = [math]::Max(0, $width - $combinedLength);

#-------------------------
# TUI
#-------------------------

# Title
[System.Console]::WriteLine("+$menuHeader+")
[System.Console]::WriteLine("|" + $menuTitle + " " * ($width - $combinedLength) + $fileExt + "|")
[System.Console]::WriteLine("+$menuHeader+")

# Body
[System.Console]::WriteLine("|" + " " * ($width - 2) + "|")
foreach ($option in $options){
    [System.Console]::WriteLine("|" + $option + " " * ($widthInnerMenu - $option.Length) + "|")
}
[System.Console]::WriteLine("|" + " " * ($width - 2) + "|")
[System.Console]::WriteLine("+$menuHeader+")
Write-Host "";