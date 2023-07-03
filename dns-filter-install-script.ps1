## Gets current date & time – used explicitly for RMM output.
function Get-Timestamp() {
    return Get-Date -UFormat "%Y-%m-%d %H:%M:%S"
}

# In order for this script to work, you will need to enable the Documentation in NinjaRMM
$NKEY = Ninja-Property-Docs-Get 'Software' DNSFILTER productKey

# File path for the MSI to download to.
$filepath = C:/temp

# Declares the name of the Software. Used below in the $installedSoftware variable.
$software = "DNS Agent"

# Looks through the HKLM registry folder below for an item where the Display name is equal to the $software variable (in this case, DNS Filter)
$installedSoftware = Get-ChildItem -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall
Path | ForEach-Object {
    $displayName = (Get-ItemProperty $_.PSPath).DisplayName
    if ($displayName -eq $software) {
        RMM-Msg "$(Get-Timestamp) DNS Filter is already installed. Termianting script."
    } 
}

#Check if software is installed. If present, terminate the script. If not, run the installer.
RMM-Msg "$(Get-Timestamp) Checking if DNSFilter is installed..."

if ($installedSoftware) {
    exit
} else {

RMM-Msg "DNS Filter is not installed. Installing now..."

mkdir $filepath
Invoke-WebRequest -Uri "https://download.dnsfilter.com/User_Agent/Windows/DNS_Agent_Setup.msi" -OutFile "C:\temp\DNS_Agent_Setup.msi"
msiexec /qn /i "C:\temp\DNS_Agent_Setup.msi" NKEY=$NKEY
}
RMM-Msg "Install complete. Removing temp files..."
Remove-Item $filepath