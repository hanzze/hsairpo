#!/bin/sh
# Alamat tujuan untuk ping
PING_TARGET="8.8.8.8"
# Perangkat serial modem
MODEM_DEVICE="/dev/ttyUSB1"
# Interval ping dalam detik
PING_INTERVAL=5
# Fungsi untuk mengirim perintah AT
send_at_command() {
    echo "AT+CFUN=1" > /dev/ttyUSB1
    echo "Modem reset command sent."
}
# Loop untuk memantau koneksi
while true; do
    # Ping target
    if ping -c 1 -W 3 $PING_TARGET > /dev/null; then
        echo "Ping berhasil ke $PING_TARGET."
    else
        echo "Ping gagal. Memulai reset modem..."
        send_at_command
        echo "Menunggu 1 menit sebelum mencoba ping lagi..."
        sleep 60
    fi
    # Tunggu sebelum ping berikutnya
    sleep $PING_INTERVAL
done
