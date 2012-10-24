class gitblit::configuration ($nonSslPort = '8080', $parent_dir = '/usr/local/gitblit') {
	
	$shutdown_port = '8091'
	$httpBinding = '0.0.0.0'
	$httpsBinding = '0.0.0.0'


	exec { gitblit_nonSSL_port:
	  	command => "sed -i -e '/^#\\?server.httpPort = / c server.httpPort = ${nonSslPort}' ${parent_dir}/current/gitblit.properties",
	  	path => ['/bin', '/usr/bin'],
	  	logoutput => true,
	  	unless => "grep '^server.httpPort = ${nonSslPort}' ${parent_dir}/current/gitblit.properties",
	  	require => Exec['gitblit_set_current'],
	  	notify => Service['gitblit']	
	 }

	 exec { gitblit_shutdown_port:
	  	command => "sed -i -e '/^#\\?server.shutdownPort = / c server.shutdownPort = ${shutdown_port}' ${parent_dir}/current/gitblit.properties",
	  	path => ['/bin', '/usr/bin'],
	  	logoutput => true,
	  	unless => "grep '^server.shutdownPort = ${shutdown_port}' ${parent_dir}/current/gitblit.properties",
	  	require => Exec['gitblit_set_current'],
	  	notify => Service['gitblit']	
	 }

	 exec { gitblit_http_binding:
	  	command => "sed -i -e '/^#\\?server.httpBindInterface = / c server.httpBindInterface = ${httpBinding}' ${parent_dir}/current/gitblit.properties",
	  	path => ['/bin', '/usr/bin'],
	  	logoutput => true,
	  	unless => "grep '^server.httpBindInterface = ${httpBinding}' ${parent_dir}/current/gitblit.properties",
	  	require => Exec['gitblit_set_current'],
	  	notify => Service['gitblit']	
	 }

	 exec { gitblit_https_binding:
	  	command => "sed -i -e '/^#\\?server.httpsBindInterface = / c server.httpsBindInterface = ${httpsBinding}' ${parent_dir}/current/gitblit.properties",
	  	path => ['/bin', '/usr/bin'],
	  	logoutput => true,
	  	unless => "grep '^server.httpsBindInterface = ${httpsBinding}' ${parent_dir}/current/gitblit.properties",
	  	require => Exec['gitblit_set_current'],
	  	notify => Service['gitblit']	
	 }
}