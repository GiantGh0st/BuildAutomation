<#
Developed by Keil Carpenter
Email: keil.carpenter@kiwirail.co.nz
For internal use only
#>

# Checks for an internet connection every 5 seconds before proceeding
[bool] $connected = $false;
if(!(test-connection 8.8.8.8 -ErrorAction Ignore -Count 1)) {
    Write-Host "No internet connection. Please connect to a network."
    while(!$connected){
        if(!(test-connection 8.8.8.8 -ErrorAction Ignore -Count 1)){
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
    # If an exception is caught, ask the user if they want to view detailed error info, if not then exit the script.
    $viewErrorInfo = Read-Host "Something went wrong while install nuget. Please revert to the manual method of enrollment. Would you like to view a detailed error description? [y/n]"
    while($viewErrorInfo -ne "y"){
        if($viewErrorInfo -eq "n"){
            exit
        }
        $viewErrorInfo = Read-Host "Something went wrong while install nuget. Please revert to the manual method of enrollment. Would you like to view a detailed error description? [y/n]"
    }
    Write-Host $_
}

# Installs autopilot package from nuget
# TODO: Error handling
try{
    Install-Script get-windowsautopilotinfo -Force
}catch{
     # If an exception is caught, ask the user if they want to view detailed error info, if not then exit the script.
    $viewErrorInfo = Read-Host "Something went wrong while installing the autopilot script. Please revert to the manual method of enrollment. Would you like to view a detailed error description? [y/n]"
    while($viewErrorInfo -ne "y"){
        if($viewErrorInfo -eq "n"){
            exit
        }
        $viewErrorInfo = Read-Host "Something went wrong while installing the autopilot script. Please revert to the manual method of enrollment. Would you like to view a detailed error description? [y/n]"
    }
    Write-Host $_
}

# Enroll the device
# TODO: error handling
try {
    get-windowsautopilotinfo.ps1 -Online
}
catch {
    # If an exception is caught, ask the user if they want to view detailed error info, if not then exit the script.
    $viewErrorInfo = Read-Host "Something went wrong when calling the autopilot script. Please revert to the manual method of enrollment. Would you like to view a detailed error description? [y/n]"
    while($viewErrorInfo -ne "y"){
        if($viewErrorInfo -eq "n"){
            exit
        }
        $viewErrorInfo = Read-Host "Something went wrong when calling the autopilot script. Please revert to the manual method of enrollment. Would you like to view a detailed error description? [y/n]"
    }
    Write-Host $_
}

