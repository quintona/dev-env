#Ensure we have unzip and curl in place as they are required for gitblit
package { "unzip":
	ensure => "installed"

}
package { "curl":
	ensure => "installed"
}

#install gitblit
#class {'gitblit': }


#TODO: install agilo using the trac::plugin definition

trac::project {"Izazi":
	repository_path		=>	"/home/vagrant/repo/puppet-trac",
	description			=>  "Default Project",
	config				=>	"defaults",
}

trac::admin {"Permissions":
	project		=>	"Izazi",
	user			=>  "vagrant",
}


class {'trac::www::basic': }
class {'trac::plugin::sitemap': }
class {'trac::plugin::batchmodify': }
class {'agilo': }
