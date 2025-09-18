#!/bin/bash

# Configuration
SSD_LABEL="Pass500"             # Replace this with the label of your SSD
MOUNT_POINT="$HOME/ExternalSSD" # Directory to mount the SSD

# Check if the SSD is connected
SSD_DEVICE=$(lsblk -l -o LABEL,NAME | grep "$SSD_LABEL" | awk '{print $2}')
if [ -z "$SSD_DEVICE" ]; then
	echo "The external SSD ($SSD_LABEL) is not connected."
	exit 1
fi

SSD_DEVICE="/dev/$SSD_DEVICE"

# Check if the directory exists; if not, create it
if [ ! -d "$MOUNT_POINT" ]; then
	mkdir -p "$MOUNT_POINT"
	echo "Created mount point at $MOUNT_POINT."
fi

# Mount the SSD
sudo mount "$SSD_DEVICE" "$MOUNT_POINT"
if [ $? -ne 0 ]; then
	echo "Failed to mount $SSD_DEVICE to $MOUNT_POINT."
	exit 1
fi

# Change ownership to the current user
sudo chown -R "$(id -u):$(id -g)" "$MOUNT_POINT"
if [ $? -ne 0 ]; then
	echo "Failed to set ownership for $MOUNT_POINT."
	exit 1
fi

echo "Successfully mounted $SSD_LABEL at $MOUNT_POINT."

# Change to the mounted directory and open a shell
cd "$MOUNT_POINT" || exit
exec $SHELL
