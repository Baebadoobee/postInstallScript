<a id="readme-top"></a>

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

### Some usage tips

First, I want to be clear about some design choices. 
- I decided to split the package list in five different files because some packages take longer and I found useful to split packages by groups. 
- I also decided to use a simple TUI for the subsequent reasons:
  - a) I still have some limitations when it comes to proper programming with other languages that would make the interface look better.
  - b) I wanted to make it simple to use and understand the usage.

You can also add the `_postInstallationPackage.psm1` file to your PowerShell modules path. 

Some usages of the module:

```sh
idpack -p your/defined/packlist # Installs a user-defined package list
idpack -u # Install utility packages
idpack -b # Install basic packages
```

_For a deeper comprehension, please refer to the modules documentation. I highly recommend you to set your own package list, to personalize your post installation script._

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Contributors:

<a href="https://github.com/Baebadoobee/postInstallScript/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Baebadoobee/postInstallScript" alt="contrib.rocks image" />
</a>
