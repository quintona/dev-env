trac::project {"Izazi":
	repository_path	=>	"/home/vagrant/dev-env/.git",
	description	=>  "Default Project",
	config => "defaults",
} -> agilo::project {"Izazi": require => trac::project['Izazi'], } -> class {'gitblit': }


trac::project {"MRS":
	repository_path	=>	"/home/vagrant/MRS/.git",
	description	=>  "Medical Rebate System",
	config => "defaults",
} -> agilo::project {"MRS": require => trac::project['MRS'], }

# Improvemens: 
# - LDAP Integration
# - Single sign on
# - portal
# - Sonar
# - Thoughtworks GO
# - Nexus

