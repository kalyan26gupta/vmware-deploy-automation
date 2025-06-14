# VMware Jenkins Automation (PowerCLI)

Automate VM provisioning in vCenter using PowerShell + Jenkins.

## 🛠️ What It Does

- Provisions a VM from template
- Configures static IP, DNS, gateway
- Attaches to specified VLAN (Port Group)
- Uses Jenkins as CI/CD interface

## 🧱 Requirements

- Jenkins (with PowerShell plugin)
- Jenkins agent with:
  - PowerCLI installed
  - Access to vCenter
- vCenter with a Windows VM template
- Customization specs enabled in vCenter

## 🔧 Setup

1. **Clone this repo** to Jenkins agent:
   ```bash
   git clone https://github.com/your-org/vmware-deploy-automation.git
   ```

2. **Add Jenkins Credentials**:
   - Go to `Manage Jenkins → Credentials → (Global)`
   - Add:
     - Type: Username & Password
     - ID: `vc-creds`

3. **Configure Jenkins Pipeline**:
   - Use `pipeline` → `Jenkinsfile` from this repo
   - Set parameters: `VM_NAME`, `IP_ADDRESS`, `PORT_GROUP`, `ADMIN_PASS`

## 📦 Example Run

| Input Field   | Value               |
|---------------|---------------------|
| VM_NAME       | `WebAppVM01`        |
| IP_ADDRESS    | `   |
| PORT_GROUP    | `VLAN10-WebServers` |
| ADMIN_PASS    | `Testing@123456`    |

## 🔐 Security

- All passwords are passed via Jenkins credentials
- Use `NonPersistent` customization specs to avoid leftovers

## 📂 File Structure

```
vmware-deploy-automation/
├── Jenkinsfile
├── deploy_vm.ps1
├── lib/
│   └── vmware_utils.ps1
├── config/
│   └── dev.json
└── README.md
```

## 🚀 Next Steps

- Add domain join automation
- Integrate with ServiceNow or ticketing
- Use GitHub Actions or Ansible for hybrid deployments
