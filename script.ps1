<#
Developed by Keil Carpenter
Email: keil.carpenter@kiwirail.co.nz
For internal use only
#>

# Checks for an internet connection every 5 seconds before proceeding
[bool] $connected = $false;
if(!(test-connection 8.8.8.8 -quiet -Count 1)) {
    Write-Host "No internet connection. Please connect to a network."
    while(!$connected){
        if(!(test-connection 8.8.8.8 -quiet -Count 1)){
            start-sleep -seconds 5;
        }else{
            $connected = $true;
        }
    }
    $connected = $true;
}

# Checks if nuget is installed and if not it will install it
try{
    Install-PackageProvider nuget -force -ForceBootstrap  
}catch{
    Write-Host "Something went wrong"
    Write-Host $_
}

# Installs autopilot package from nuget
# TODO: Error handling
try{
    Install-Script get-windowsautopilotinfo -Force
}catch{
    Write-Host "Something went wrong"
    Write-Host $_
}

# Enroll the device
# TODO: error handling
try {
    get-windowsautopilotinfo.ps1 -Online
}
catch {
    Write-Host "Something went wrong"
    Write-Host $_
}

