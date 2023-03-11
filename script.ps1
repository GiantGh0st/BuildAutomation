
# Check for an active internet connection before proceeding
[bool] $connected = $false;
if(!(test-connection 8.8.8.8 -quiet -Count 1)) {
    Write-Host "No internet connection. Please connect to a network."
    while(!$connected){
        if(!(test-connection 8.8.8.8 -quiet -Count 1)){
            start-sleep -seconds 1;
        }else{
            $connected = $true;
        }
    }
    $connected = $true;
}

# Installs nuget package manager
try{
    Install-PackageProvider nuget -force -ForceBootstrap #Checks if nuget is installed and if not it will install it 
}catch{
    Write-Host "Something went wrong"
    Write-Host $_
}

# Installs autopilot package from nuget
# TODO: Error handling
Install-Script get-windowsautopilotinfo -Force

# Enroll the device
# TODO: error handling
get-windowsautopilotinfo.ps1 -Online
