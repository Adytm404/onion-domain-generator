# Skrip Setup Tor Hidden Service Sederhana

Skrip Bash ini mengotomatiskan proses pengaturan Tor Hidden Service di sistem berbasis Debian (seperti Ubuntu). Skrip ini akan menginstal paket yang diperlukan, menjalankan server web Python lokal pada port yang Anda tentukan, dan mengonfigurasi Tor untuk mengarahkannya ke server tersebut.

---

## Kebutuhan Sistem

* Sistem operasi berbasis Debian (yang menggunakan manajer paket `apt`).
* Akses `sudo`, karena skrip perlu menginstal paket dan memodifikasi file konfigurasi sistem.

---

## Cara Menjalankan

1.  **Berikan Izin Eksekusi**
    Sebelum menjalankan skrip, Anda harus membuatnya dapat dieksekusi:
    ```bash
    chmod +x tor.sh
    ```

2.  **Jalankan Skrip**
    Jalankan skrip menggunakan `sudo` atau sebagai root (karena skrip ini memanggil `sudo` di dalamnya untuk instalasi dan konfigurasi):
    ```bash
    ./tor.sh
    ```

3.  **Masukkan Port**
    Skrip akan meminta Anda memasukkan port yang ingin digunakan untuk server web lokal. Port ini *bukan* port publik, melainkan port di `127.0.0.1` (localhost) tempat server Python akan berjalan.
    ```
    Masukkan port yang ingin digunakan untuk hidden service (contoh: 8080):
    8080
    ```

4.  **Tunggu Proses Selesai**
    Skrip akan secara otomatis:
    * Menginstal `tor` dan `python3`.
    * Membuat direktori server.
    * Menjalankan server HTTP Python di latar belakang.
    * Mengonfigurasi Tor (`/etc/tor/torrc`).
    * Merestart layanan Tor.

5.  **Dapatkan Alamat .onion Anda**
    Setelah selesai, skrip akan menampilkan alamat `.onion` Anda di terminal.

---

## Lokasi File HTML Kustom

Untuk mengubah konten yang ditampilkan di situs .onion Anda, Anda perlu mengedit file `index.html` atau menambahkan file lain ke direktori server.

* **Lokasi Direktori Server:** `~/tor_service` (Folder `tor_service` di dalam direktori Home Anda).
* **File HTML Utama:** `~/tor_service/index.html`

Anda dapat mengedit file `index.html` tersebut atau menempatkan file HTML, CSS, dan gambar Anda sendiri di dalam direktori `~/tor_service`.