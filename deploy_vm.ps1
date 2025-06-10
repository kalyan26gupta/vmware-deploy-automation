param (
    [string]$VMName,
    [string]$Template,
    [string]$Datastore,
    [string]$PortGroup,
    [string]$IPAddress,
    [string]$SubnetMask,
    [string]$Gateway,
    [string]$DNS1,
    [string]$DNS2,
    [string]$AdminPassword
)

. "$PSScriptRoot\lib\vmware_utils.ps1"

Connect-ToVCenter -Server "vcenter.local" -User "svc_jenkins" -Password "YourPasswordHere"

New-VMWithCustomization -VMName $VMName -Template $Template `
    -Datastore $Datastore -PortGroup $PortGroup `
    -IPAddress $IPAddress -SubnetMask $SubnetMask `
    -Gateway $Gateway -DNS1 $DNS1 -DNS2 $DNS2 `
    -AdminPassword $AdminPassword
