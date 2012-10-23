
class {'gitblit': }

trac::project {"Izazi":
	repository_path		=>	"/home/vagrant/dev-env/.git",
	description			=>  "Default Project",
	config				=>	"defaults",
} 

agilo::project {"Izazi": }

Class['gitblit'] -> trac::project['Izazi'] -> agilo::project['Izazi']

# Improvemens: 
# - LDAP Integration
# - Single sign on
# - portal
# - Sonar
# - Thoughtworks GO
# - Nexus

