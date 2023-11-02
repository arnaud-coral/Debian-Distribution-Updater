# 🚀 Debian Distribution Updater

A simple Bash script for updating Debian to the next release. It checks for the current Debian version, determines the next version, updates the sources.list, upgrades packages, and cleans up. Optionally, it can reboot the system after a major version upgrade.

## 🛠️ Usage

1. Make sure you have root or sudo privileges to run this script.
2. Download the script or copy its contents.
3. Run the script using the following command:
```shell
sudo bash debian-update.sh
```
## 🔎 Features

- **Automatically Determines Next Debian Version:** The script automatically detects the current Debian version and determines the next version based on a predefined list of supported codenames.
- **Updates Sources.list:** It updates the /etc/apt/sources.list file to point to the new release.
- **Updates Package List:** The script updates the package list to fetch the latest package information.
- **Upgrades Installed Packages:** It upgrades the installed packages to the latest available versions.
- **Performs Distribution Upgrade:** A distribution upgrade is performed to migrate to the next Debian release.
- **Removes Unneeded Packages:** The script removes packages that are no longer needed.
- **Cleans Package Cache:** It cleans up the package cache to save disk space.
- **Optional System Reboot:** After a major version upgrade, it suggests a system reboot. You can choose to reboot or skip.

## 📜 License

This script is © 2023 by Arnaud Coral. It's licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/). Please refer to the license for permissions and restrictions.