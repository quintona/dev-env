#!/bin/sh
echo "Installing JDK!"

chmod 777 /vagrant_data/jdk-6u35-linux-x64.bin

yes | /vagrant_data/jdk-6u35-linux-x64.bin

mv jdk1.6.0_35 /opt

ln -s /opt/jdk1.6.0_35/bin/java /usr/bin
JAVA_HOME=/opt/jdk1.6.0_35
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH

echo "JDK Installed!"
