RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo "${GREEN}[###NGROK ADB INSTALLER###] Updating...${NC}"
pkg update -y && pkg upgrade

echo "${GREEN}[###NGROK ADB INSTALLER###] Installing wget proot tar${NC}"
pkg install wget proot tar -y

echo "${GREEN}[###NGROK ADB INSTALLER###] Going to termux bin directory${NC}"
cd /data/data/com.termux/files/usr/bin

echo "${GREEN}[###NGROK ADB INSTALLER###] Making uninstaller script${NC}"
touch ./ngrok-adb-uninstall.sh
cat <<EOT >> ./ngrok-adb-uninstall.sh
# Change directory
cd /data/data/com.termux/files/usr/bin

# Remove directories and files
echo "Uninstalling Ngrok-adb kali chroot!"
rm -rf ./kali-binds
rm -rf ./kali-fs
rm -rf ./start-kali.sh
echo "Uninstall finished!"
EOT
chmod +x ./ngrok-adb-uninstall.sh

echo "${GREEN}[###NGROK ADB INSTALLER###] Downloading${NC}"
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Kali/kali.sh 

echo "${GREEN}[###NGROK ADB INSTALLER###] Executing kali installerr script${NC}"
chmod 777 ./kali.sh
./kali.sh
rm -rf ./kali.sh

echo "${GREEN}[###NGROK ADB INSTALLER###] Navigating to kali-fs/bin${NC}"
cd /data/data/com.termux/files/usr/bin/kali-fs/bin

echo "${GREEN}[###NGROK ADB INSTALLER###] Downloading and extracting ngrok to kali-fs/bin${NC}"
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz && tar -xzf ngrok-v3-stable-linux-arm64.tgz && rm ngrok-v3-stable-linux-arm64.tgz && chmod 777 ngrok

echo "${GREEN}[###NGROK ADB INSTALLER###] Downloading and extracting adb to kali-fs/bin, as well as chmod 777 the binary${NC}"
wget https://github.com/qhuyduong/arm_adb/releases/download/v1.0.39-aarch64/adb && chmod 777 adb

echo "${GREEN}[###NGROK ADB INSTALLER###] Navigating back to termux home directory${NC}"
cd 

echo "${GREEN}[###NGROK ADB INSTALLER###] Ngrok-adb Install complete! Starting kali chroot!${NC}"
start-kali.sh