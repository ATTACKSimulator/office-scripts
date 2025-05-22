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

---

### What Are Allowed Senders, Safe Senders, Transport Rules, and Defender Settings?

- **Allowed Senders**: These are email addresses or domains that you trust. Adding them to the allowed senders list helps make sure emails from these sources are not sent to your spam or junk folder.

- **Safe Senders**: These are trusted senders added to each user's mailbox. Marking a sender as safe helps ensure their emails (including images and links) always appear correctly in Outlook, and are not blocked or sent to junk.

- **Transport Rules**: These are special rules set by your organization to control how emails are handled. For example, a transport rule can make sure important emails from ATTACK Simulator are always delivered, even if they look suspicious.

- **Defender Settings**: These are security settings in Microsoft 365 Defender that help prevent good emails from being blocked by mistake. Adding ATTACK Simulator to these lists helps make sure your phishing tests work as expected.

---

### Script Details

- **`_allowed-senders-add.ps1`**: Lets Microsoft 365 know that emails from ATTACK Simulator are safe, so they don't go to spam.
- **`_allowed-senders-check.ps1`**: Checks if ATTACK Simulator is already marked as safe.
- **`_allowed-senders-remove.ps1`**: Removes ATTACK Simulator from the safe list, so their emails might go to spam again.

- **`_safe-senders-add.ps1`**: Makes sure emails from ATTACK Simulator always show up in your inbox, with images and links working in Outlook.
- **`_safe-senders-check.ps1`**: Lets you check if ATTACK Simulator is set as safe for a specific mailbox.
- **`_safe-senders-remove.ps1`**: Stops treating ATTACK Simulator as safe, so their emails might be blocked or have images hidden.

- **`_transport-rule-add.ps1`**: Sets up a rule so that emails from ATTACK Simulator are always delivered, even if they look suspicious.
- **`_transport-rule-check.ps1`**: Checks if this special delivery rule is in place.
- **`_transport-rule-remove.ps1`**: Removes the rule, so emails from ATTACK Simulator are treated like any other email.

- **`_defender-add.ps1`**: Tells Microsoft 365 Defender not to block or filter emails from ATTACK Simulator, so your phishing tests work.
- **`_defender-check.ps1`**: Checks if Defender is set up to allow ATTACK Simulator emails.
- **`_defender-remove.ps1`**: Removes ATTACK Simulator from Defender's allow list, so their emails might be blocked again.

- **`whitelist.ps1`**: Runs all the above steps at once, making sure ATTACK Simulator emails are delivered and work as intended for your tests.

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

### Load Images Automatically in Outlook

If you want to make sure that images and links in ATTACK Simulator emails always load in Outlook (and are not blocked or hidden), run:

```powershell
./_safe-senders-add.ps1
```

This will add ATTACK Simulator to the safe senders list for all mailboxes, so images and content display without warnings.

### Remove All ATTACK Simulator Settings

To undo all changes and remove ATTACK Simulator from all allow lists, safe senders, transport rules, and Defender settings, run each of the following scripts:

```powershell
./_allowed-senders-remove.ps1
./_safe-senders-remove.ps1
./_transport-rule-remove.ps1
./_defender-remove.ps1
```

This will restore your Microsoft 365 environment to its previous state, as if ATTACK Simulator was never added.

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
