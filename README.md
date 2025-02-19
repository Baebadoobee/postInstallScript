<a id="readme-top"></a>

<style type="text/css">
p#warning {
  max-width: 60%; 
  font-size: 18px; 
  text-align: left; 
  font-weight: bold; 
  position: relative; 
  margin: 0;
}
p#warning:hover {
  color: #f1f1f1;
}
</style>

<!--
<br />
<div align="center">
  <a href="https://github.com/github_username/repo_name">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>
</div>
 -->
 
<h3 align="center">Post-Installation Script (idpack)</h3>
  <p align="center">Written in PowerShell.</p>
<br />

<!--
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#usage">Usage</a></li>
  </ol>
</details>
-->

<!-- ABOUT THE PROJECT -->
## Installation

1. Clone the repo into your home folder:

   ```sh
   git clone https://github.com/Baebadoobee/postInstallScript.git .pIS
   ```
2. Make `launcher.sh` and `installationScript.ps1` files executable to ensure they can be run as scripts:
   
   ```sh
   cd .pIS
   chmod +x launcher.sh
   chmod +x installationScript.ps1
   ```

<!-- USAGE EXAMPLES -->
## Usage

After a fresh Arch Linux installation, run the following:

```sh
./launcher.sh
```

The script is parted into two functionalities: A script that installs a preset list of packages and a dotfiles manager.

### Preset package installation

On launch, you will be greeted by a simple UI, you can select any option. If you want to remove a package from the list you can just comment it out and if you decide to add one, just append it to the bottom of the file (or uncomment it).

### Dotfiles Manager

You can access it either via the `installationScript.ps1` or via its own file `_dotfilesManager.ps1`, but it's preferred to be launched by the installation script because it sets up an important environment variable. 
The Dotfiles Manager itself works as an easy import/export tool, that can also install the desired config files to your system.

#### Some usage tips

First, I want to be clear about some design choices. 
- I decided to split the package list into five different files because some packages take longer and I found it useful to split packages by groups. 
- I also decided to use a simple TUI for the subsequent reasons:
  - I still have some limitations when it comes to proper programming with other languages that would make the interface look better.
  - I wanted to make it simple to use and understand the usage.

You can also add all the modules (.psm1) here to your own PowerShell modules path. 
Again, I highly recommend you to check out the modules themselves, for customization purposes.

Some usages of the modules:

```pwsh
#idpack
idpack -p your/defined/packlist # Installs a user-defined package list
idpack -u # Install utility packages
idpack -b # Install basic packages

#slinkf
slinkf -p origin/path -d destination/path # You don't actually have to write -p and -d, the positional parameters take care of it themselves
slinkf "origin/path" "destination/path" -n # A NoConfirm switch exemple
```
</br></br>

<p id="warning">I am currently working in some problems on the code, errors are likely to occour!</p>
<p align="left">Please check out the <a href="ISSUES.md">issues</a> page</p>


##
_For a deeper comprehension, please refer to the modules documentation. I highly recommend you to set your own package list, to personalize your post-installation script._

<p align="right"><a href="#readme-top">back to top</a></p>

### Contributors:

<a href="https://github.com/Baebadoobee/postInstallScript/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Baebadoobee/postInstallScript" alt="contrib.rocks image" />
</a>

