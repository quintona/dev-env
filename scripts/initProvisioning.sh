#!/bin/sh
echo "Starting provisioning"

#apply
cd dev-env/manifests
puppet apply init.pp --verbose --modulepath=../modules/ --debug
puppet apply trac.pp --verbose --modulepath=../modules/ --debug
puppet apply agilo.pp --verbose --modulepath=../modules/ --debug

echo "Provisioning complete!"
