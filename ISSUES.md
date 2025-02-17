## Issue list

- The reference path for $PSScriptRoot is located to the module folder [**Solved** - see C1.]
- The list of packages seem to be considered as a single name [**Solved** - see C2.]

### Some notes

- Add a section to README.md on how to add the user pwsh modules and how to make a alias to use `idpack` direct from the terminal.

<!-- 

!Expanded comments on problems.

*C1. To be honest, I tried to address this issue assigning an environment variable'$env:pISHome = "$env:HOME/.pIS".' If you run with some path problems, check this.

*C2. Solved by parsing the files with '(Get-Content "$env:pISHome/packages/_appearancePacks" | Where-Object { $_ -notmatch '^#' })'. The use of $($var) was optional.

-->