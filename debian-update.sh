#!/bin/bash

# Function for logging
log() {
  local log_level=$1
  local message=$2
  logger -t "DebianUpdateScript" -p "user.$log_level" "$message"
  echo "$message"
}

# Check if the user is root or using sudo
if [ "$EUID" -ne 0 ]; then
  log "err" "Please run this script as root or using sudo."
  exit 1
fi

# Log the start of the script
log "info" "Starting Debian update script."

# Define an array of supported Debian release codenames
supported_codenames=("buster" "bullseye" "bookworm")  # Add more as needed

# Detect the current Debian version
current_version=$(lsb_release -cs)

log "info" "Detected current Debian version: $current_version"

# Determine the next Debian version based on the current version
for ((i = 0; i < ${#supported_codenames[@]}; i++)); do
  if [ "${supported_codenames[i]}" = "$current_version" ]; then
    if [ $((i + 1)) -lt ${#supported_codenames[@]} ]; then
      next_version="${supported_codenames[i + 1]}"
    fi
    break
  fi
done

if [ -z "$next_version" ]; then
  log "err" "Failed to determine the next Debian version."
  exit 1
fi

log "info" "Next Debian version: $next_version"

# Update the sources.list to point to the new release
sed -i "s/$current_version/$next_version/g" /etc/apt/sources.list

log "info" "Updated sources.list to point to Debian $next_version."

# Update the package list
apt update

log "info" "Updated package list."

# Upgrade installed packages
apt upgrade -y

log "info" "Upgraded installed packages."

# Perform a distribution upgrade
apt dist-upgrade -y

log "info" "Performed distribution upgrade."

# Remove no longer needed packages
apt autoremove -y

log "info" "Removed no longer needed packages."

# Clean up package cache
apt clean

log "info" "Cleaned up package cache."

# Reboot the system (recommended after a major version upgrade)
log "info" "The system has been updated to Debian $next_version. Rebooting..."
read -p "Reboot now? (y/n): " -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  reboot
fi
