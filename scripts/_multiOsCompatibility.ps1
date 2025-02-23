# I will try to address multi-system compatibility in the next steps

switch ($PSVersionTable.Os) {
    "Arch Linux" {
        $packageManager = @(
            "yay",
            "paru",
            "pacman"
        )

        $packageManager;
    }

    Default { 
        Write-Output "Unsupported OS";
    }
}