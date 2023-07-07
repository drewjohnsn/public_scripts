### 6/30/2023 THIS IS NOT A COMPLETED SCRIPT.

# Put your SentinelOne Token here
sentinelToken = "YOUR S1 TOKEN"

#You will need to upload the pkg to another site in order for the curl function to work.
downloadLink = "YOUR DOWNLOAD LINK"

pkgName = "YOUR PKG NAME.pkg"

#########

# Check if SentinelOne is already install
if [ -d /Applications/SentinelOne] ;
then
    echo "SentinelOne is Already Installed"
    exit 0
else

curl -L -o $pkgName $downloadLink

#Pass the S1 Token to the PKG
echo $sentinelToken /tmp/com.sentinelone.registration-token

#Install Agent
/usr/sbin/installer -pkg /tmp/$pkgName -target /
fi