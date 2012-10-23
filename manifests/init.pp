#Ensure we have unzip and curl in place as they are required for gitblit


class {'gitblit': }

trac::project {"Izazi":
	repository_path		=>	"/home/vagrant/repo/puppet-trac/.git",
	description			=>  "Default Project",
	config				=>	"defaults",
} 

agilo::project {"Izazi": }

Class['gitblit'] -> trac::project['Izazi'] -> agilo::project['Izazi']

# Improvemens: 
# - LDAP Integration
# - Single sign on
# - portal
# 

