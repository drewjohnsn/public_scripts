$NKEY = NInja-Property-Docs-Get 'Software' DNSFILTER productKey

mkdir C:\temp
Invoke-WebRequest -Uri "https://download.dnsfilter.com/User_Agent/Windows/DNS_Agent_Setup.msi" -OutFile "C:\temp\DNS_Agent_Setup.msi"
msiexec /qn /i "C:\temp\DNS_Agent_Setup.msi" NKEY=$NKEY