class agilo  {
	
	$download_file = "agilo_source.tar.gz"
	$download_url = "http://www.agilofortrac.com/en/download/agilo_source.tar.gz"
	
	exec { agilo_download:
		command => "curl -v --progress-bar -o '/var/tmp/${download_file}' '$download_url'",
    	creates => "/var/tmp/${download_file}",
    	path => ["/bin", "/usr/bin"],
    	logoutput => true,
	}
	
	exec { agilo_extract:
		command => "tar -xvwzf -C /var/tmp/agilo /var/tmp/${download_file}",
	    path => ["/bin", "/usr/bin"],
	    require => Exec['agilo_download'],
	}
	
	exec { agilo_install:
		command => "python setup.py install",
		cwd => "/var/tmp/agilo",
	    path => ["/bin", "/usr/bin"],
	    require => Exec['agilo_extract'],
	}
}