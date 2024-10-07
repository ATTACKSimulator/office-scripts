https://github.com/user-attachments/assets/62bb1e3e-7ac9-4ce4-82fa-f320b6b80574


# ATTACK Simulator Office Scripts

Welcome to the ATTACK Simulator Office Scripts repository!

This project offers a collection of PowerShell scripts tailored for managing and configuring spam filter policies, safe senders, and transport rules within Microsoft 365 environments. These tools are invaluable for simulating phishing scenarios and enhancing your organization’s email security. The latest ATTACK Simulator domains are automatically downloaded as needed, ensuring you always have the most up-to-date information.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Scripts Overview](#scripts-overview)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction

The ATTACK Simulator Office Scripts repository provides a suite of PowerShell scripts to manage spam filter policies, configure safe senders, and set up transport rules. These tools help security professionals simulate phishing attacks and configure their email environment for improved security.

## Prerequisites

Before using these scripts, ensure you have:

- A Microsoft 365 account with appropriate permissions.
- The latest PowerShell installed on Windows or Mac
- Minimal knowledge of terminal commands (like changing directories and running a script).

## Scripts Overview

This repository includes the following scripts:

### Spam Filter Policy Scripts

- **`_allowed-senders-add.ps1`**: Adds domains to the allowed senders list in a spam filter policy.
- **`_allowed-senders-check.ps1`**: Checks if specified domains are in the allowed senders list.
- **`_allowed-senders-remove.ps1`**: Removes domains from the allowed senders list.

### Safe Senders Scripts

- **`_safe-senders-add.ps1`**: Adds domains to the safe senders list for all mailboxes.
- **`_safe-senders-check.ps1`**: Checks the safe senders configuration for a specific mailbox.
- **`_safe-senders-remove.ps1`**: Removes domains from the safe senders list for all mailboxes.

### Transport Rule Scripts

- **`_transport-rule-add.ps1`**: Adds a transport rule to handle emails based on specific headers.
- **`_transport-rule-check.ps1`**: Checks the existence and details of a specified transport rule.
- **`_transport-rule-remove.ps1`**: Removes a specified transport rule.

### Defender Scripts

- **`_defender-add.ps1`**: Adds a rules to Microsoft 365 Defender.
- **`_defender-check.ps1`**: Checks the existence of the required rules in Microsoft 365 Defender.
- **`_defender-remove.ps1`**: Removes ATTACK Simulator rules from Microsoft 365 Defender.

### General Scripts

- **`whitelist.ps1`**: A general-purpose script for adding all ATTACK Simulator whitelist settings. It combines the \_allowed-senders-add.ps1, \_safe-senders-add.ps1, \_transport-rule-add.ps1 and \_defender-add.ps1 scripts.

## Usage

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/ATTACKSimulator/office-scripts.git
   cd office-scripts
   ```

   You can also download the repository, by clicking the green Code button and then **Download as zip**.

2. **Run the Scripts:**

   In PowerShell, navigate to the folder where you downloaded the repo, and execute the desired script.

   For example, to apply all whitelisting settings type:

   ```powershell
   ./whitelist.ps1
   ```

   You can also run individual scripts if needed. If you want to remove all the ATTACK Simulator domains from the allowed senders list just type:

   ```powershell
   ./_allowed-senders-remove.ps1
   ```

3. **Monitor and Review:**

   - Check the output of each script to verify the changes.
   - Review the settings and configurations to ensure they align with your security requirements.

## Contributing

We welcome contributions to enhance these scripts. To contribute:

1. Fork the repository.
2. Create a new branch for your changes.
3. Commit your changes and push them to your fork.
4. Submit a pull request with a description of your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contact

For questions or support related to the ATTACK Simulator Office Scripts, please reach out via the [Issues](https://github.com/ATTACKSimulator/office-scripts/issues) page or contact us at [support@attacksimulator.com](mailto:support@attacksimulator.com).

---
