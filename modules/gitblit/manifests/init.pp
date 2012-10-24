class gitblit ($version = '1.1.0', $nonSslPort = '8080') {
	
	$parent_dir = "/usr/local/gitblit"
	
	class { 'gitblit::install':
		version => $version,
		parent_dir => $parent_dir
	}

	class { 'gitblit::configuration':
		nonSslPort => $nonSslPort,
		parent_dir => $parent_dir
	}
	include gitblit::service
	
  	Class['gitblit::install']
  	-> Class['gitblit::configuration'] -> Class['gitblit::service']
}