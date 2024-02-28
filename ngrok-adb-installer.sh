echo "[###NGROK ADB INSTALLER###] Updating..."
pkg update -y && pkg upgrade

echo "[###NGROK ADB INSTALLER###] Installing wget proot tar"
pkg install wget proot tar -y

echo "[###NGROK ADB INSTALLER###] Going to termux bin directory"
cd /data/data/com.termux/files/usr/bin

echo "[###NGROK ADB INSTALLER###] Making uninstaller script"
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

echo "[###NGROK ADB INSTALLER###] Downloading"
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Kali/kali.sh 

echo "[###NGROK ADB INSTALLER###] Executing kali installerr script"
chmod 777 ./kali.sh
./kali.sh
rm -rf ./kali.sh

echo "[###NGROK ADB INSTALLER###] Navigating to kali-fs/bin"
cd /data/data/com.termux/files/usr/bin/kali-fs/bin

echo "[###NGROK ADB INSTALLER###] Downloading and extracting ngrok to kali-fs/bin"
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz && tar -xzf ngrok-v3-stable-linux-arm64.tgz && rm ngrok-v3-stable-linux-arm64.tgz && chmod 777 ngrok

echo "[###NGROK ADB INSTALLER###] Downloading and extracting adb to kali-fs/bin, as well as chmod 777 the binary"
wget https://github.com/qhuyduong/arm_adb/releases/download/v1.0.39-aarch64/adb && chmod 777 adb

echo "[###NGROK ADB INSTALLER###] Navigating back to termux home directory"
cd 

echo "[###NGROK ADB INSTALLER###] Ngrok-adb Install complete! Starting kali chroot!"
start-kali.sh