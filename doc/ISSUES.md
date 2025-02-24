<!-- <style type="text/css">
p#C1:hover, p#C2:hover, p#C3:hover {
  color: #f1f1f1;
}
</style> -->


## Issue list

- The reference path for $PSScriptRoot is located to the module folder [ **Solved** - see <a href="#C1">C1.</a> ]
- The list of packages seem to be considered as a single name [ **Solved** ]
- There is a big error handling problem in the code [ **Unsolved** ]
- Many issues with typos in the package list [ **Solved** ]
- Symlinks beeing created in the wrong folders [ **Solved** - see <a href="#C2">C2.</a> ]


### Some notes

- Remember to configure `/etc/pacman.conf`.
- Add a section to README.md on how to add the user pwsh modules and how to make a alias to use `pipack` direct from the terminal. [ **Done** ]
- I have to change the Post Installation function to be more generic, therefore, esier to catch any error that might occur. [ **Done** ]
- Multi OS Compatibility. [ _Undone_ ]
</br>

## Expanded comments on problems.

<p id="C1">C1. To be honest, I tried to address this issue assigning an environment variable'$env:pISHome = "$env:HOME/.pIS".' If you run with some path problems, check this.</p>

<p id="C2">C2. The module works fine. I found a typo in the Dotfiles_Manager's main file, but I didn't had a chance to test it again.</p>

<p align="right"><a href="../README.md">back</a></p>

### Contributors:

<a href="https://github.com/Baebadoobee/postInstallScript/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Baebadoobee/postInstallScript" alt="contrib.rocks image" />
</a>