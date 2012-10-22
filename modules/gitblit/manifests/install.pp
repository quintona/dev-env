class gitblit::install ($version = '1.1.0', $parent_dir = '/usr/local/gitblit') {
	
	$download_file = "gitblit-${version}.zip"
	$download_url = "https://gitblit.googlecode.com/files/${download_file}"
	$version_dir = "${parent_dir}/gitblit-${version}"
	$current_dir = "${parent_dir}/current"
	$daemon_script = "gitblit-ubuntu"
	
	group { 'gitblit':, ensure => present }
	user { 'gitblit':
		ensure => present,
		managehome => false,
		home => '/home/gitblit',
		gid => 'gitblit',
		require => Group['gitblit'],
		comment => 'GitBlit Server account'
	}

	exec { gitblit_download:
		command => "curl -v --progress-bar -o '/var/tmp/${download_file}' '$download_url'",
    	creates => "/var/tmp/${download_file}",
    	path => ["/bin", "/usr/bin"],
    	logoutput => true,
    	unless => "/usr/bin/test -d '${version_dir}'"
	}

	file { 'gitblit-parent-dir':
	    path => $parent_dir,
		owner => 'gitblit', group => 'gitblit',
	  	ensure => directory,
		mode => 0777, 
		require => [ Group['gitblit'], User['gitblit'] ]
	}

	file { 'gitblit-home':
	    path => $version_dir,
		owner => 'gitblit', group => 'gitblit',
	  	ensure => directory,
		mode => 0777, 
		require => [ Exec['gitblit_download'], Group['gitblit'], User['gitblit'] ]
	}

	exec { gitblit_extract:
		command => "unzip -ao /var/tmp/${download_file} -d ${version_dir}",
		user => 'gitblit', group => 'gitblit',
	    creates => "${version_dir}/ext",
	    path => ["/bin", "/usr/bin"],
	    require => [ Exec['gitblit_download'], File['gitblit-home'], Group['gitblit'], User['gitblit'] ],
	    unless => "/usr/bin/test -d '${version_dir}/ext'"
	}

	exec { gitblit_set_current:
		command => "ln -s ${version_dir} ${parent_dir}/current",
		creates => "/usr/local/nexus/current",
		path => ["/bin", "/usr/bin"],
		require => [ Exec['gitblit_extract'], Group['gitblit'], User['gitblit'] ]
	}

	exec { gitblit_daemon:
		command => "cp ${version_dir}/${daemon_script} /etc/init.d/gitblit",
		creates => "/etc/init.d/gitblit",
		path => ["/bin", "/user/bin"],
		require => Exec['gitblit_set_current'], 
		unless => "/usr/bin/test -f /etc/init.d/gitblit"
	}

	file { "daemon_file":
		path => "/etc/init.d/gitblit",
		ensure => file,
		mode => 0777,
		require => Exec['gitblit_daemon']
	}

	exec { gitblit_daemon_opts:
	  	command => "sed -i -e '/^#\\?GITBLIT_PATH=/ c GITBLIT_PATH=${version_dir}' /etc/init.d/gitblit",
	  	path => ['/bin', '/usr/bin'],
	  	logoutput => true,
	  	unless => "grep '^GITBLIT_PATH=${version_dir}' /etc/init.d/gitblit",
	  	require => Exec['gitblit_daemon'],
	  	notify => Service['gitblit']	
	  }
}