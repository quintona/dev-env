#Ensure we have unzip and curl in place as they are required for gitblit
package { "unzip":
	ensure => "installed"

}
package { "curl":
	ensure => "installed"
}

#install gitblit
#class {'gitblit': } -> 

trac::project {"Izazi":
	repository_path		=>	"/home/vagrant/repo/puppet-trac/.git",
	description			=>  "Default Project",
	config				=>	"defaults",
} 

agilo::project {"Izazi": }

trac::project['Izazi'] -> agilo::project['Izazi']

