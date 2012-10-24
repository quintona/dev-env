class gitblit ($version = '1.1.0') {
	
	$parent_dir = "/usr/local/gitblit"
	
	class { 'gitblit::install':
		version => $version,
		parent_dir => $parent_dir
	}

	class { 'gitblit::configuration': }
	include gitblit::service
	
  	Class['gitblit::install']
  	-> Class['gitblit::configuration'] -> Class['gitblit::service']
}