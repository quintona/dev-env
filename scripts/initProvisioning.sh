#!/bin/sh
echo "Starting provisioning"

#apply
cd dev-env/manifests
puppet apply init.pp --verbose --modulepath=../modules/ --debug

echo "Provisioning complete!"
