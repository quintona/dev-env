class agilo  {
	
	$download_file = "agilo_source.tar.gz"
	$download_url = "http://www.agilofortrac.com/en/download/agilo_source.tar.gz"
	$agilo_version = "0.9.8"
	
	exec { agilo_download:
		command => "curl -v --progress-bar -o '/var/tmp/${download_file}' '$download_url'",
    	creates => "/var/tmp/${download_file}",
    	path => ["/bin", "/usr/bin"],
    	logoutput => true,
	}
	
	exec { agilo_extract:
		command => "tar -xvzf /var/tmp/${download_file}",
		cwd => "/var/tmp",
	    path => ["/bin", "/usr/bin"],
	    require => Exec['agilo_download'],
	}
	
	exec { agilo_install:
		command => "python setup.py install",
		cwd => "/var/tmp/agilo-${agilo_version}",
	    path => ["/bin", "/usr/bin"],
	    require => Exec['agilo_extract'],
	}
	
    
    define project{
      include agilo
      exec { "upgrade-trac-env-$name":
        command => "trac-admin /var/lib/trac/$name/ upgrade",
        path => "/usr/bin",
        require => Exec["agilo_install"],
        returns => [0,1,2],
      }
	
	  exec {"restart-apache2-after-agilo":
  	    command => "/etc/init.d/apache2 restart",
  	    require => Exec["upgrade-trac-env-$name"],
      }
    }
}