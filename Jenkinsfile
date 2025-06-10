pipeline {
    agent any

    parameters {
        string(name: 'VCENTER_SERVER', defaultValue: 'vcenter.lab.local', description: 'vCenter hostname')
        string(name: 'VM_NAME', defaultValue: 'TestVM01', description: 'Name of the new VM')
        string(name: 'TEMPLATE', defaultValue: 'Win2019Template', description: 'VM template to clone')
        string(name: 'DATASTORE', defaultValue: 'Datastore01', description: 'Datastore for the VM')
        string(name: 'PORT_GROUP', defaultValue: 'VLAN_100', description: 'vSwitch port group or VLAN')
        string(name: 'IP_ADDRESS', defaultValue: '192.168.100.101', description: 'Static IP address')
        string(name: 'SUBNET_MASK', defaultValue: '255.255.255.0', description: 'Subnet mask')
        string(name: 'GATEWAY', defaultValue: '192.168.100.1', description: 'Gateway IP address')
        string(name: 'DNS1', defaultValue: '8.8.8.8', description: 'Primary DNS server')
        string(name: 'DNS2', defaultValue: '8.8.4.4', description: 'Secondary DNS server')
        password(name: 'ADMIN_PASS', defaultValue: '', description: 'Local administrator password')
        string(name: 'DOMAIN', defaultValue: 'corp.local', description: 'Domain to join')
        string(name: 'DOMAIN_USER', defaultValue: 'joinuser', description: 'Domain join user')
        password(name: 'DOMAIN_PASS', defaultValue: '', description: 'Domain join password')
        string(name: 'TAG', defaultValue: 'Environment:Test', description: 'Tag for VM')
    }

    environment {
        VC_CREDS_ID = 'vc-creds' // Reference your Jenkins stored credentials
    }

    stages {
        stage('Deploy VM') {
            steps {
                script {
                    powershell """
                        .\\deploy_vm.ps1 `
                        -VCServer ${params.VCENTER_SERVER} `
                        -VCUser \$env:VC_USER `
                        -VCPassword \$env:VC_PASS `
                        -VMName ${params.VM_NAME} `
                        -Template ${params.TEMPLATE} `
                        -Datastore ${params.DATASTORE} `
                        -PortGroup ${params.PORT_GROUP} `
                        -IPAddress ${params.IP_ADDRESS} `
                        -SubnetMask ${params.SUBNET_MASK} `
                        -Gateway ${params.GATEWAY} `
                        -DNS1 ${params.DNS1} `
                        -DNS2 ${params.DNS2} `
                        -AdminPassword ${params.ADMIN_PASS} `
                        -Domain ${params.DOMAIN} `
                        -DomainUser ${params.DOMAIN_USER} `
                        -DomainPass ${params.DOMAIN_PASS} `
                        -Tag ${params.TAG}
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Job completed."
        }
    }
}
