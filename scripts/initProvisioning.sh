#!/bin/sh
echo "Initializing provisioning"

# Install git
apt-get install git

#get the provisioning scripts
cd /home/vagrant
git clone https://github.com/quintona/dev-env.git

#apply
cd dev-env/manifests
puppet apply init.pp --verbose --modulepath=../modules/ --debug

echo "Provisioning complete!"
