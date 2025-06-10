# vmware-deploy-automation
# VMware Jenkins Automation (PowerCLI)

Automate VM provisioning in vCenter using PowerShell + Jenkins.

---

## 🛠️ What It Does

- Provisions a VM from template
- Configures static IP, DNS, gateway
- Attaches to specified VLAN (Port Group)
- Uses Jenkins as CI/CD interface

---

## 🧱 Requirements

- Jenkins (with PowerShell plugin)
- Jenkins agent with:
  - PowerCLI installed
  - Access to vCenter
- vCenter with a Windows VM template
- Customization specs enabled in vCenter

---

## 🔧 Setup

1. **Clone this repo** to Jenkins agent:
   ```bash
   git clone https://github.com/your-org/vmware-deploy-automation.git
