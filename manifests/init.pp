trac::project {"Izazi":
	repository_path	=>	"/home/vagrant/dev-env/.git",
	description	=>  "Default Project",
	config => "defaults",
	stage => first
} -> agilo::project {"Izazi": 
	require => trac::project['Izazi'],
	stage => last,
} -> class {'gitblit': 
	stage => main
}


# Improvemens: 
# - LDAP Integration
# - Single sign on
# - portal
# - Sonar
# - Thoughtworks GO
# - Nexus

