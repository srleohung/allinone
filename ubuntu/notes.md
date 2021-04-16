# ubuntu

## Connect to WiFi use Terminal
- Add your wifi to configuration
```bash
sudo nano /etc/netplan/50-cloud-init.yaml
```
```bash
# This file is generated from information provided by the datasource. Changes
# to it will not persist across an instance reboot. To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        eth0:
            dhcp4: true
            optional: true
    version: 2
    wifis:
        wlan0:
            dhcp4: true
            optional: true
            access-points:
                "SSID_name":
                    password: "WiFi_password"
```

- Start wpa_supplicant
```bash
sudo systemctl start wpa_supplicant
```

- Restart ubuntu
```bash
sudo reboot
```

- Apply netplan
```bash
sudo netplan generate
sudo netplan apply
```

## Convert non-progressive JPEG images to progressive JPEG images
```
mogrify -interlace plane *.jpg
```