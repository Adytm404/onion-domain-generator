![App Screenshot](https://raw.githubusercontent.com/Adytm404/onion-domain-generator/refs/heads/main/img/1.png)

# Simple Tor Hidden Service Setup Script

This Bash script automates the process of setting up a simple Tor Hidden Service on a Debian-based system (like Ubuntu). It installs the necessary packages, runs a local Python web server on a port you specify, and configures Tor to route to it.

---

## Requirements

* A Debian-based operating system (which uses the `apt` package manager).
* `sudo` access, as the script needs to install packages and modify system configuration files.

---

## How to Run

1.  **Make the Script Executable**
    Before running the script, you must grant it execution permissions:
    ```bash
    chmod +x tor.sh
    ```

2.  **Run the Script**
    Execute the script (it handles `sudo` internally for necessary commands):
    ```bash
    ./tor.sh
    ```

3.  **Enter Your Port**
    The script will first prompt you to enter a port for the local web server. This is *not* the public port, but the port on `127.0.0.1` (localhost) that the Python server will listen on.
    ```
    Masukkan port yang ingin digunakan untuk hidden service (contoh: 8080):
    8080
    ```

4.  **Wait for Setup to Complete**
    The script will then automatically perform the following steps:
    * Install `tor` and `python3`.
    * Create the server directory.
    * Start the Python HTTP server in the background.
    * Configure Tor (`/etc/tor/torrc`).
    * Restart the Tor service.

5.  **Get Your .onion Address**
    Once finished, the script will print your new `.onion` address to the terminal.

---

## Custom HTML File Location

To change the content displayed on your .onion site, you need to edit the `index.html` file or add other files to the server directory.

* **Server Directory Location:** `~/tor_service` (The `tor_service` folder in your Home directory).
* **Main HTML File:** `~/tor_service/index.html`

You can edit this `index.html` file or place your own HTML, CSS, and image files inside the `~/tor_service` directory to serve them.
