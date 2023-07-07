#Defines a variable for the file path
$Path = "C:\installs"

#The following If statement checks for the defined file path above and if it doesn't exist, it creates it.
if (!(Test-Path -pathtype Container $path )) {
    New-Item C:\installs -ItemType Directory
}

$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer