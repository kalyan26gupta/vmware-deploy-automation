function Connect-ToVCenter {
    param($Server, $User, $Password)
    Connect-VIServer -Server $Server -User $User -Password $Password
}

function New-VMWithCustomization {
    param (
        $VMName, $Template, $Datastore, $PortGroup,
        $IPAddress, $SubnetMask, $Gateway,
        $DNS1, $DNS2, $AdminPassword,
        $Domain, $DomainUser, $DomainPassword,
        $Tag
    )

    $nicMapping = New-OSCustomizationNicMapping -IpMode UseStaticIP `
        -IpAddress $IPAddress -SubnetMask $SubnetMask `
        -DefaultGateway $Gateway -Dns @($DNS1, $DNS2)

    $customSpec = New-OSCustomizationSpec -Name "Spec-$VMName" -Type NonPersistent `
        -FullName "Admin" -OrgName "ITDept" -OSType Windows `
        -TimeZone 085 -NamingScheme Fixed -NamingPrefix $VMName `
        -AdminPassword $AdminPassword -NICMapping $nicMapping `
        -Domain $Domain -DomainUserName $DomainUser -DomainPassword $DomainPassword

    $vm = New-VM -Name $VMName -VM $Template -Datastore $Datastore `
                 -NetworkName $PortGroup -OSCustomizationSpec $customSpec `
                 -Confirm:$false

    # Tagging the VM
    if (-not (Get-Tag -Name $Tag -ErrorAction SilentlyContinue)) {
        $category = "Automation"
        if (-not (Get-TagCategory -Name $category -ErrorAction SilentlyContinue)) {
            New-TagCategory -Name $category -Cardinality Single -EntityType VirtualMachine
        }
        New-Tag -Name $Tag -Category $category
    }

    $vm | New-TagAssignment -Tag $Tag
}
