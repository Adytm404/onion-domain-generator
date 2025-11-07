#!/bin/bash

# === Step 0: Validasi & Input Port ===
echo "Masukkan port yang ingin digunakan untuk hidden service (contoh: 8080):"
read CUSTOM_PORT

if ! [[ "$CUSTOM_PORT" =~ ^[0-9]+$ ]]; then
  echo "Port tidak valid. Harus berupa angka."
  exit 1
fi

# === Step 1: Instalasi Tor dan Python HTTP Server ===
echo "[1/6] Menginstal Tor dan modul server..."
sudo apt update
sudo apt install -y tor torbrowser-launcher python3

# === Step 2: Setup Direktori Server ===
echo "[2/6] Membuat direktori server..."
mkdir -p ~/tor_service
cd ~/tor_service
echo "<html><body>Tor Hidden Service Aktif di Port $CUSTOM_PORT</body></html>" > index.html

# === Step 3: Menjalankan HTTP Server ===
echo "[3/6] Menjalankan Python HTTP server di port $CUSTOM_PORT..."
nohup python3 -m http.server --bind 127.0.0.1 "$CUSTOM_PORT" > /dev/null 2>&1 &

# === Step 4: Konfigurasi Tor Hidden Service ===
echo "[4/6] Mengonfigurasi torrc..."
TORRC_PATH="/etc/tor/torrc"
HSDIR="/var/lib/tor/hidden_service"

sudo sed -i "/HiddenServiceDir/d" "$TORRC_PATH"
sudo sed -i "/HiddenServicePort/d" "$TORRC_PATH"
echo "HiddenServiceDir $HSDIR" | sudo tee -a "$TORRC_PATH" > /dev/null
echo "HiddenServicePort 80 127.0.0.1:$CUSTOM_PORT" | sudo tee -a "$TORRC_PATH" > /dev/null

# === Step 5: Restart Tor Service ===
echo "[5/6] Merestart layanan Tor..."
sudo systemctl restart tor
sleep 5

# === Step 6: Menampilkan Alamat .onion ===
echo "[6/6] Menampilkan alamat .onion..."
if [ -f "$HSDIR/hostname" ]; then
  echo "✅ Hidden service berhasil dibuat!"
  echo "Alamat .onion Anda:"
  sudo cat "$HSDIR/hostname"
else
  echo "❌ Gagal menghasilkan alamat .onion. Periksa konfigurasi Tor."
fi
