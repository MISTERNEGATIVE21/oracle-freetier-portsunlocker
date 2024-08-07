# oracle-freetier-portsunlocker
Free Oracle Cloud Tier Ports Unlockers
## Script Overview

The `installer.sh` script performs the following tasks:
1. Checks if `firewalld` is installed and installs it if necessary.
2. Ensures `firewalld` is started and enabled.
3. Flushes existing `iptables` rules.
4. Sets default `iptables` policies to accept.
5. Saves the `iptables` configuration.
6. Restarts the `firewalld` service.
7. Opens all TCP and UDP ports.
8. Installs CasaOS.

## Usage

To run the script on a remote machine using Root User and not as Sudo . Use `curl`, follow these steps:
### Step 0: Enter the Root mode

```sh
sudo su -
```
### Step 1: Download and Execute the Script

Run the following command on your target machine to download and execute the script:

```sh
curl -sL https://raw.githubusercontent.com/MISTERNEGATIVE21/oracle-freetier-portsunlocker/master/installer.sh -o installer.sh &&  chmod +x installer.sh &&  ./installer.sh
```
