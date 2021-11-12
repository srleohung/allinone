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

## OpenSSL
### CSR certificate
Use the following command to create a CSR using your newly generated private key:
```bash
openssl req -new -newkey rsa:2048 -nodes -keyout localhost.key -out localhost.csr
openssl x509 -req -days 365 -in localhost.csr -signkey localhost.key -out localhost.crt
```
### SAN certificate
Copy `/etc/ssl/openssl.cnf` to the working directory and change the configuration file:
```
[ CA_default ]
# Extension copying option: use with caution.
copy_extensions = copy

[ req ]
req_extensions = v3_req # The extensions to add to a certificate request

[ v3_req ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = localhost
```
Use the following command to create a SAN certificate:
```bash
openssl genrsa -des3 -out root.key 2048
openssl req -new -x509 -key root.key -out root.crt -days 365
openssl req -new -key root.key -out root.csr 
openssl genpkey -algorithm RSA -out localhost.key
openssl req -new -nodes -key localhost.key -out localhost.csr -days 365 -config openssl.cnf -extensions v3_req
openssl x509 -req -days 365 -in localhost.csr -out localhost.pem -CA root.crt -CAkey root.key -CAcreateserial -extfile openssl.cnf -extensions v3_req
```
### Add certificate
Copy the contents of `localhost.crt` to `/etc/ssl/certs/ca-certificates.crt`

## Add user to sudo group
```bash
sudo usermod -aG sudo www-data
```

## Allow user to run command without password
sudo nano /etc/sudoers.d/www-data
```bash
%$group  ALL= NOPASSWD: $command
# e.g. %www-data  ALL= NOPASSWD: /bin/systemctl restart apache2.service 
```