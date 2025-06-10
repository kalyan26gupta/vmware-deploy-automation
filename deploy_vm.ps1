param (
    [string]$VCServer,
    [string]$VCUser,
    [string]$VCPassword,
    [string]$VMName,
    [string]$Template,
    [string]$Datastore,
    [string]$PortGroup,
    [string]$IPAddress,
    [string]$SubnetMask,
    [string]$Gateway,
    [string]$DNS1,
    [string]$DNS2,
    [string]$AdminPassword,
    [string]$Domain,
    [string]$DomainUser,
    [string]$DomainPassword,
    [string]$Tag
)

# Import custom functions
. "$PSScriptRoot\lib\vmware_utils.ps1"

# Connect to vCenter
Connect-ToVCenter -Server $VCServer -User $VCUser -Password $VCPassword

# Deploy and customize the VM
New-VMWithCustomization `
    -VMName $VMName -Template $Template -Datastore $Datastore `
    -PortGroup $PortGroup -IPAddress $IPAddress -SubnetMask $SubnetMask `
    -Gateway $Gateway -DNS1 $DNS1 -DNS2 $DNS2 `
    -AdminPassword $AdminPassword -Domain $Domain `
    -DomainUser $DomainUser -DomainPassword $DomainPassword `
    -Tag $Tag
