#!/bin/bash

# Define default archive value
DEFAULT_ARCHIVE="designerlauncher.tar.gz"

# Use the provided argument or fall back to the default
ARCHIVE="${1:-$DEFAULT_ARCHIVE}"
INSTALL_DIR="/usr/local/bin/designerlauncher"
DESKTOP_FILE="designerlauncher.desktop"

# Function to check if required packages are installed
check_packages() {
    REQUIRED_PACKAGES=("tar" "desktop-file-validate" "gtk-update-icon-cache")
    for PACKAGE in "${REQUIRED_PACKAGES[@]}"; do
        if ! command -v "$PACKAGE" &> /dev/null; then
            echo "Error: Required package '$PACKAGE' is not installed."
            echo "Please install it using your package manager."
            exit 1
        fi
    done
}

# Check for required packages
check_packages

# Create the installation directory if it doesn't exist
sudo rm -r "$INSTALL_DIR"
sudo mkdir -p "$INSTALL_DIR"

# Extract the archive directly into the installation directory
if [ -f "$ARCHIVE" ]; then
    echo "Extracting $ARCHIVE to $INSTALL_DIR..."
    sudo tar -xzf "$ARCHIVE" -C "$INSTALL_DIR" --strip-components=1
else
    echo "Error: Archive $ARCHIVE not found."
    exit 1
fi

# Create or modify the .desktop file
echo "Creating or modifying $DESKTOP_FILE..."
cat <<EOF | sudo tee "$INSTALL_DIR/$DESKTOP_FILE" > /dev/null
[Desktop Entry]
Type=Application
Version=1.0
Name=Designer Launcher
Comment=Ignition Designer Launcher
Path=$INSTALL_DIR
Exec=bash -c "cd $INSTALL_DIR/app && ./designerlauncher.sh &" . %k
Terminal=false
Icon=$INSTALL_DIR/app/launcher.png
EOF

# Change ownership of the installed files to the current user
CURRENT_USER=$(whoami)
echo "Changing ownership of installed files to user: $CURRENT_USER"
sudo chown -R "$CURRENT_USER:$CURRENT_USER" "$INSTALL_DIR"


# Validate the .desktop file
if [ -f "$INSTALL_DIR/$DESKTOP_FILE" ]; then
    echo "Validating $DESKTOP_FILE..."
    desktop-file-validate "$INSTALL_DIR/$DESKTOP_FILE"
    
    # Install the .desktop file using desktop-file-install
    echo "Installing $DESKTOP_FILE..."
    sudo desktop-file-install --dir=/usr/share/applications "$INSTALL_DIR/$DESKTOP_FILE"
else
    echo "Error: Desktop file $DESKTOP_FILE not found in the extracted folder."
    exit 1
fi

# Update icon cache if necessary
if [ -d "/usr/share/icons/hicolor" ]; then
    sudo gtk-update-icon-cache /usr/share/icons/hicolor
fi

# Update the desktop database
echo "Updating desktop database..."
sudo update-desktop-database /usr/share/applications

echo "Installation completed successfully."

