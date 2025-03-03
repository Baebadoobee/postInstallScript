#!/usr/bin/pwsh

# Note.: Remember to add this script to the main one
# Note.: Remember to update confirmation prompts

$ErrorActionPreference = 'Stop';
$isoPath = "/home/bae/sda1/iso"; # Change the path to your ISO files here
$isoList = (Get-ChildItem $isoPath);
$usbList = (Get-ChildItem /dev/disk/by-id/usb-*) | Where-Object {$_ -notmatch 'part'}; 

$menuTitle = " Live USB Manager ";
do {  
  $eNum = 0;
  $options = ($usbList | ForEach-Object {
    Write-Output " $eNum`. $($_.Name)";
    ++$eNum
  });

  Clear-Host; & "$scriptPath/_tui.ps1";
  
  $actionTui = Read-Host "Select a Device"
  $usbTarget = $usbList[$actionTui];

  switch ($actionTui) {
    {$usbTarget.Count -ge $_} {
      $options = ($isoList | ForEach-Object {
        Write-Output " $eNum`. $($_.Name)";
        ++$eNum
      });
      Clear-Host; & "./_tui.ps1";

      $actionSubTui = Read-Host "Select a ISO";
      $isoTarget = $isoList[$actionSubTui];
      switch ($actionSubTui) {
        "wipe" { 
          Write-Output "`nWARNING: This action will erase all your files. Do you want to continue? (y/n)";
          $continue = ([System.Console]::ReadKey($true));

          if (($($continue.KeyChar) -eq "y") -or ($($continue.Key) -eq "ENTER")) {
            try {
              wipefs --all $usbTarget;
            }
            catch {
              Write-Output "`nAn error occurred while trying to wipe a USB Stick.";
              Start-Sleep -Seconds 1;
              Break do;
            }
            finally {
              Write-Output "`nProcess done!";
              Start-Sleep -Seconds 1;
            }
          }
        }

        Default {
          Write-Output "`nWARNING: This action will overwrite your files. Do you want to continue? (y/n)";
          $continue = ([System.Console]::ReadKey($true));

          if (($($continue.KeyChar) -eq "y") -or ($($continue.Key) -eq "ENTER")) {
            Write-Output "`nMaking a bootable USB Stick. Please wait.`n";

            try {
              cat "$($isoTarget.FullName)" > "$($usbTarget.FullName)";
            }
            catch {
              Write-Output "`nAn error occurred while attempting to make a new bootable USB Stick.";
              $_;
              Start-Sleep -Seconds 1;
              Break do; 
            }
            finally {
              Write-Output "`nProcess done!";
              Start-Sleep -Seconds 1;
            }
          }
        }
      }
    }

    {$_ -ne ($usbTarget.Count - 1)} { 
      Write-Output "Invalid Device";
      Start-Sleep -Seconds 1;
      Continue;
    }
  }
} while ($true)
