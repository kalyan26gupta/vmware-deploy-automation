function Connect-ToVCenter {
    param (
        [string]$Server,
        [string]$User,
        [string]$Password
    )
    Write-Host "Connecting to vCenter $Server..."
    Connect-VIServer -Server $Server -User $User -Password $Password -Force
}

function New-VMWithCustomization {
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
        [string]$AdminPassword,
        [string]$Domain,
        [string]$DomainUser,
        [string]$DomainPassword,
        [string]$Tag
    )

    $CustomSpec = New-OSCustomizationSpec -Name "${VMName}_Spec" -OSType Windows `
        -Type NonPersistent -FullName "AutoDeploy" -OrgName "IT" `
        -TimeZone 035 -AdminPassword $AdminPassword -Domain $Domain `
        -DomainUsername $DomainUser -DomainPassword $DomainPassword `
        -NamingScheme Fixed -NamingPrefix $VMName `
        -IpMode UseStaticIP -IPAddress $IPAddress `
        -SubnetMask $SubnetMask -DefaultGateway $Gateway `
        -DnsServer $DNS1,$DNS2

    Write-Host "Deploying VM $VMName..."
    New-VM -Name $VMName -Template $Template -Datastore $Datastore `
        -OSCustomizationSpec $CustomSpec -NetworkName $PortGroup `
        -Confirm:$false | Out-Null

    if ($Tag) {
        Write-Host "Applying tag $Tag"
        New-TagAssignment -Entity (Get-VM $VMName) -Tag $Tag -Confirm:$false
    }

    Write-Host "VM $VMName deployed successfully."
}
