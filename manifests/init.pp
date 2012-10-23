trac::project {"Izazi":
	repository_path	=>	"/home/vagrant/dev-env/.git",
	description	=>  "Default Project",
	config => "defaults",
} -> agilo::project {"Izazi": require => trac::project['Izazi'], } -> class {'gitblit': }


# Improvemens: 
# - LDAP Integration
# - Single sign on
# - portal
# - Sonar
# - Thoughtworks GO
# - Nexus

