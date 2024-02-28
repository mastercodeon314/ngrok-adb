RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

printf "${GREEN}[###NGROK ADB INSTALLER###] Updating...\n${NC}"
pkg update -y && pkg upgrade

printf "${GREEN}[###NGROK ADB INSTALLER###] Installing wget proot tar\n${NC}"
pkg install wget proot tar -y

printf "${GREEN}[###NGROK ADB INSTALLER###] Going to termux bin directory\n${NC}"
cd /data/data/com.termux/files/usr/bin

printf "${GREEN}[###NGROK ADB INSTALLER###] Making uninstaller script\n${NC}"
touch ./ngrok-adb-uninstall
cat <<EOT >> ./ngrok-adb-uninstall
# Change directory
cd /data/data/com.termux/files/usr/bin
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color


# Remove directories and files
printf "${GREEN}[###NGROK ADB INSTALLER###] Uninstalling Ngrok-adb kali chroot!\n${NC}"
rm -rf ./kali-binds
rm -rf ./kali-fs
rm -rf ./start-kali.sh
printf "${GREEN}[###NGROK ADB INSTALLER###] Uninstall finished!\n${NC}"
rm -- "$0"
EOT
chmod +x ./ngrok-adb-uninstall

printf "${GREEN}[###NGROK ADB INSTALLER###] Downloading\n${NC}"
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Kali/kali.sh 

printf "${GREEN}[###NGROK ADB INSTALLER###] Executing kali installerr script\n${NC}"
chmod 777 ./kali.sh
./kali.sh
rm -rf ./kali.sh

printf "${GREEN}[###NGROK ADB INSTALLER###] Navigating to kali-fs/bin\n${NC}"
cd /data/data/com.termux/files/usr/bin/kali-fs/bin

printf "${GREEN}[###NGROK ADB INSTALLER###] Downloading and extracting ngrok to kali-fs/bin\n${NC}"
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz && tar -xzf ngrok-v3-stable-linux-arm64.tgz && rm ngrok-v3-stable-linux-arm64.tgz && chmod 777 ngrok

printf "${GREEN}[###NGROK ADB INSTALLER###] Downloading and extracting adb to kali-fs/bin, as well as chmod 777 the binary\n${NC}"
wget https://github.com/qhuyduong/arm_adb/releases/download/v1.0.39-aarch64/adb && chmod 777 adb

printf "${GREEN}[###NGROK ADB INSTALLER###] Navigating back to termux home directory\n${NC}"
cd 

printf "${GREEN}[###NGROK ADB INSTALLER###] Ngrok-adb Install complete! Starting kali chroot!\n${NC}"
start-kali.sh