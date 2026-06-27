#!/usr/bin/env bash
# pi-env installer
# Version: 0.0.1
# Usage: curl -sL https://raw.githubusercontent.com/Githubwujinming/pi-env/main/install.sh | bash

set -euo pipefail

INSTALL_DIR="${PI_ENV_DIR:-$HOME/.pi}"
BIN_DIR="${PI_ENV_BIN:-$HOME/.local/bin}"
VERSION="0.0.1"

# Check pi
command -v pi >/dev/null 2>&1 || {
	echo "Error: pi not found. Please install pi-coding-agent first"
	exit 1
}

# Create directories
mkdir -p "$INSTALL_DIR" "$BIN_DIR"

# Copy script (local) or download (remote)
SCRIPT_SRC="$(cd "$(dirname "$0")" && pwd)/pi-env.sh"
if [ -f "$SCRIPT_SRC" ]; then
	cp "$SCRIPT_SRC" "$INSTALL_DIR/pi-env.sh"
else
	echo "Downloading pi-env.sh..."
	if command -v curl >/dev/null 2>&1; then
		curl -sL "https://raw.githubusercontent.com/Githubwujinming/pi-env/main/pi-env.sh" -o "$INSTALL_DIR/pi-env.sh"
	elif command -v wget >/dev/null 2>&1; then
		wget -q "https://raw.githubusercontent.com/Githubwujinming/pi-env/main/pi-env.sh" -O "$INSTALL_DIR/pi-env.sh"
	else
		echo "Error: curl or wget is required"
		exit 1
	fi
fi

chmod +x "$INSTALL_DIR/pi-env.sh"
ln -sf "$INSTALL_DIR/pi-env.sh" "$BIN_DIR/pi-env"

# Check PATH
case ":$PATH:" in
*":$BIN_DIR:"*) ;;
*)
	echo "  Hint: $BIN_DIR is not in PATH. Add it to your shell config:"
	echo "    echo 'export PATH=\"\$PATH:$BIN_DIR\"' >> ~/.bashrc"
	echo "    source ~/.bashrc"
	;;
esac

echo "pi-env v$VERSION installed successfully"
echo "Run 'pi-env help' to get started"
