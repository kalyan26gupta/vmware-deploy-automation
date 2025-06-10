pipeline {
    agent any

    parameters {
        string(name: 'VM_NAME', defaultValue: 'VM-Test')
        string(name: 'IP_ADDRESS', defaultValue: '192.168.10.101')
        string(name: 'PORT_GROUP', defaultValue: 'VLAN10-Dev')
        password(name: 'ADMIN_PASS', defaultValue: '', description: 'Admin password')
    }

    environment {
        TEMPLATE = 'Win2019Template'
        DATASTORE = 'DS-Dev01'
    }

    stages {
        stage('Deploy VM') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'vc-creds', passwordVariable: 'VC_PASS', usernameVariable: 'VC_USER')]) {
                    powershell script: """
                        Connect-VIServer -Server vcenter.local -User $env:VC_USER -Password $env:VC_PASS
                        ./deploy_vm.ps1 `
                            -VMName '${params.VM_NAME}' `
                            -Template '$env:TEMPLATE' `
                            -Datastore '$env:DATASTORE' `
                            -PortGroup '${params.PORT_GROUP}' `
                            -IPAddress '${params.IP_ADDRESS}' `
                            -SubnetMask '255.255.255.0' `
                            -Gateway '192.168.10.1' `
                            -DNS1 '8.8.8.8' -DNS2 '8.8.4.4' `
                            -AdminPassword '${params.ADMIN_PASS}'
                    """
                }
            }
        }
    }
}
