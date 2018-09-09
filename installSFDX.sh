#!/bin/bash
apt-get update
apt-get install -y wget xz-utils
wget https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz
mkdir sfdx
tar xJf sfdx-linux-amd64.tar.xz -C sfdx --strip-components 1
./sfdx/install
rm -rf sfdx

#Clean up APT
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*