##POWERON OFF Azure VM ResourceGroup

#Change Directory to working
cd 'C:\Users\aphilippov\OneDrive\Documents\PowerShell Lib'

# First, log in
Login-AzureRmAccount

# Set the path in to which your profile will be saved
$Path = 'C:\Users\aphilippov\OneDrive\Documents\PowerShell Lib\AzureRmProfile.json'

# Save the profile - we do this every time because it does time out.
Save-AzureRmContext -Path $Path -Force

# Get the objects to work on.
$VMObjects = Get-AzureRmVM -ResourceGroupName 'APhilippov-CloudConnect-Webinar'

# Create the Workflow
Workflow PowerOn {
    
# the parameters. The objects to work on and the profile path are mandatory
    param (
        [parameter(Mandatory=$true)]
        [psobject]$AzureRmVmObject,
        [parameter(Mandatory=$true)]
        [psobject]$ProfilePath
    )

    # Perform a parallel execution - each is a separate job, so needs the profile every time!
    foreach -parallel -throttlelimit 5 ($VM in $AzureRmVmObject ) {
        $Profile = Import-AzureRmContext -Path $ProfilePath # Get the profile
        Write-Output "[[[ STARTUP REQUESTED ]]] FOR $($VM.Name)..." # Give some information
        $StartRtn = Start-AzureRmVM -Name $VM.Name -ResourceGroupName $VM.ResourceGroupName # Perform the action.

	    if ($StartRtn.Status -ne 'Succeeded') { Write-Output ("[[[$($VM.Name)]]] failed to start!") }
	    else { Write-Output ("[[[ $($VM.Name) ]]] has been started.") } # Give some information
    }
}

# Invoke the Workflow, providing the objects and the profile path.
PowerOn -AzureRmVmObject $VMObjects -ProfilePath $Path