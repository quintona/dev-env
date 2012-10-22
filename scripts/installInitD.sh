#!/bin/sh

#get the files in the right place, so that things will start when the machine is restarted
cp /vagrant_data/init.d/MoneyMobiliser /etc/init.d/
cp /vagrant_data/init.d/MobiliserPortal /etc/init.d/
cp /vagrant_data/init.d/MobiliserJMS /etc/init.d/
cp /vagrant_data/init.d/BrandMobiliser /etc/init.d/

#ensure the permissions are correct
chmod 755 /etc/init.d/MoneyMobiliser
chmod 755 /etc/init.d/MobiliserPortal
chmod 755 /etc/init.d/MobiliserJMS
chmod 755 /etc/init.d/BrandMobiliser