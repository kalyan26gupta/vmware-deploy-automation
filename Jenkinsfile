pipeline {
    agent any

    parameters {
        string(name: 'VCENTER_SERVER', defaultValue: 'vcenter.domain.local', description: 'vCenter FQDN or IP')
        string(name: 'VM_NAME', defaultValue: 'VM-Demo', description: 'New VM name')
        string(name: 'TEMPLATE', defaultValue: 'Win2019Template', description: 'vSphere Template name')
        string(name: 'DATASTORE', defaultValue: 'DS-Prod01', description: 'Datastore name')
        string(name: 'PORT_GROUP', defaultValue: 'VLAN-Dev', description: 'PortGroup to connect VM to')
        string(name: 'IP_ADDRESS', defaultValue: '192.168.1.100', description: 'Static IP')
        string(name: 'SUBNET_MASK', defaultValue: '255.255.255.0', description: 'Subnet mask')
        string(name: 'GATEWAY', defaultValue: '192.168.1.1', description: 'Default gateway')
        string(name: 'DNS1', defaultValue: '8.8.8.8', description: 'Primary DNS')
        string(name: 'DNS2', defaultValue: '8.8.4.4', description: 'Secondary DNS')
        password(name: 'ADMIN_PASS', defaultValue: '', description: 'Local Administrator password')
        string(name: 'DOMAIN', defaultValue: 'corp.local', description: 'Domain to join')
        string(name: 'DOMAIN_USER', defaultValue: 'joinuser', description: 'Domain join user')
        password(name: 'DOMAIN_PASS', defaultValue: '', description: 'Domain join password')
        string(name: 'TAG', defaultValue: 'Environment:Dev', description: 'vSphere Tag')
    }

    environment {
        VC_CREDS_ID = 'vc-creds' // Jenkins credential ID for vCenter
    }

    stages {
        stage('Deploy VM') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${env.VC_CREDS_ID}", usernameVariable: 'VC_USER', passwordVariable: 'VC_PASS')]) {
                    powershell script: """
                        \$ErrorActionPreference = 'Stop'
                        ./deploy_vm.ps1 `
                            -VCServer '${params.VCENTER_SERVER}' `
                            -VCUser '\$env:VC_USER' `
                            -VCPassword '\$env:VC_PASS' `
                            -VMName '${params.VM_NAME}' `
                            -Template '${params.TEMPLATE}' `
                            -Datastore '${params.DATASTORE}' `
                            -PortGroup '${params.PORT_GROUP}' `
                            -IPAddress '${params.IP_ADDRESS}' `
                            -SubnetMask '${params.SUBNET_MASK}' `
                            -Gateway '${params.GATEWAY}' `
                            -DNS1 '${params.DNS1}' `
                            -DNS2 '${params.DNS2}' `
                            -AdminPassword '${params.ADMIN_PASS}' `
                            -Domain '${params.DOMAIN}' `
                            -DomainUser '${params.DOMAIN_USER}' `
                            -DomainPassword '${params.DOMAIN_PASS}' `
                            -Tag '${params.TAG}'
                    """
                }
            }
        }
    }
}
