echo "NGROK ADB INSTALLER Updating..."

# Update and upgrade packages
pkg update -y && pkg upgrade

echo "NGROK ADB INSTALLER Installing wget proot tar"

# Install required packages
pkg install wget proot tar -y

echo "NGROK ADB INSTALLER Navigating to termux bin dir"

# Navigate to the termux bin directory
cd /data/data/com.termux/files/usr/bin

echo "NGROK ADB INSTALLER Downloading"

# Download and run the Kali Linux installation script
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Kali/kali.sh 

echo "NGROK ADB INSTALLER Executing kali installerr script"

./kali.sh

rm -rf ./kali.sh

echo "NGROK ADB INSTALLER Navigating to kali-fs/bin"

# Navigate to the bin directory inside the Kali Linux filesystem
cd /data/data/com.termux/files/usr/bin/kali-fs/bin

echo "NGROK ADB INSTALLER Downloading and extracting ngrok to kali-fs/bin"

# Download and extract ngrok
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz && tar -xzf ngrok-v3-stable-linux-arm64.tgz && rm ngrok-v3-stable-linux-arm64.tgz && chmod 777 ngrok

echo "NGROK ADB INSTALLER Downloading and extracting adb to kali-fs/bin, as well as chmod 777 the binary"

# Download and set permissions for adb
wget https://github.com/qhuyduong/arm_adb/releases/download/v1.0.39-aarch64/adb && chmod 777 adb

echo "NGROK ADB INSTALLER Navigating back to termux home directory"

# Navigate back to the home directory
cd /data/data/com.termux/files/home

echo "NGROK ADB INSTALLER Ngrok-adb Install complete! Starting kali chroot!"

# Start Kali Linux
start-kali.sh