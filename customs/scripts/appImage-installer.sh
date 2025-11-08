
#!/usr/bin/env bash
# Interactive AppImage installer with category selection

set -e

echo "➡️ Welcome to AppImage Installer!"

# 1️⃣ Ask for App Name
read -p "Enter App Name: " APP_NAME
if [ -z "$APP_NAME" ]; then
    echo "App name cannot be empty!"
    exit 1
fi

# 2️⃣ Ask for AppImage path
read -p "Enter path to AppImage file: " APPIMAGE_PATH
if [ ! -f "$APPIMAGE_PATH" ]; then
    echo "File does not exist!"
    exit 1
fi
APPIMAGE_PATH=$(realpath "$APPIMAGE_PATH")
APPIMAGE_NAME=$(basename "$APPIMAGE_PATH" .AppImage)

# 3️⃣ Ask for icon path (optional)
read -p "Enter path to icon file (leave empty to extract from AppImage): " ICON_PATH
if [ -n "$ICON_PATH" ] && [ ! -f "$ICON_PATH" ]; then
    echo "Icon file does not exist! Will try to extract from AppImage."
    ICON_PATH=""
fi

# 4️⃣ Ask for category (optional)
read -p "Enter application category (leave empty for default 'Utility'): " APP_CATEGORY
if [ -z "$APP_CATEGORY" ]; then
    APP_CATEGORY="Utility"
fi

# Directories
INSTALL_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
APPIMAGE_DEST="$INSTALL_DIR/$APP_NAME.AppImage"
DESKTOP_FILE="$DESKTOP_DIR/$APP_NAME.desktop"

mkdir -p "$INSTALL_DIR" "$DESKTOP_DIR" "$ICON_DIR"

# Move AppImage
mv "$APPIMAGE_PATH" "$APPIMAGE_DEST"
chmod +x "$APPIMAGE_DEST"

# Handle icon
if [ -z "$ICON_PATH" ]; then
    echo "➡️ Extracting icon from AppImage..."
    TMPDIR=$(mktemp -d)
    if "$APPIMAGE_DEST" --appimage-extract >/dev/null 2>&1; then
        ICON_PATH_EXTRACTED=$(find squashfs-root -type f \( -name '*.png' -o -name '*.svg' \) | head -n 1)
        if [ -n "$ICON_PATH_EXTRACTED" ]; then
            ICON_PATH="$ICON_DIR/$APP_NAME.png"
            cp "$ICON_PATH_EXTRACTED" "$ICON_PATH"
            echo "✅ Icon extracted to $ICON_PATH"
        else
            ICON_PATH="application-x-executable"
            echo "⚠️ No icon found in AppImage. Using default."
        fi
        rm -rf squashfs-root
    else
        ICON_PATH="application-x-executable"
        echo "⚠️ Failed to extract icon. Using default."
    fi
fi

# Create .desktop file
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=$APP_NAME
Exec=$APPIMAGE_DEST
Icon=$ICON_PATH
Type=Application
Categories=$APP_CATEGORY;
StartupNotify=true
Terminal=false
EOF

chmod +x "$DESKTOP_FILE"

# Update desktop database
update-desktop-database "$DESKTOP_DIR" >/dev/null 2>&1 || true

echo "🎉 $APP_NAME installed successfully!"
echo "You can now find it in your application menu under category '$APP_CATEGORY'."

